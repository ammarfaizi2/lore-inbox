Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289299AbSBJGvW>; Sun, 10 Feb 2002 01:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289315AbSBJGvM>; Sun, 10 Feb 2002 01:51:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35846 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289299AbSBJGvD>;
	Sun, 10 Feb 2002 01:51:03 -0500
Message-ID: <3C66181C.95DF04E3@zip.com.au>
Date: Sat, 09 Feb 2002 22:50:04 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG preserve registers
In-Reply-To: <Pine.LNX.4.33.0202092211001.10024-100000@home.transmeta.com>,
		<Pine.LNX.4.33.0202092211001.10024-100000@home.transmeta.com> <m1k7tl6ek2.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> One possibility is to do something like:
> 
> ud2
> .word __LINE__
> .long 1f
> .section __FILE__
> .linkonce discard
> 1: .asciz __FILE__
> .previous
> 
> Which will put each filename string in it's own section and let the
> linker merge the duplicates.

That would work.  When it didn't I r'ed tfm:

	http://www.gnu.org/manual/gas-2.9.1/html_node/as_102.html

	"This directive is only supported by a few object file formats;
	 as of this writing, the only object file format which supports
	 it is the Portable Executable format used on Windows NT."


-
