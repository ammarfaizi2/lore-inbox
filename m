Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266863AbRGFV3M>; Fri, 6 Jul 2001 17:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266865AbRGFV3C>; Fri, 6 Jul 2001 17:29:02 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:54791 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266860AbRGFV2x>; Fri, 6 Jul 2001 17:28:53 -0400
Date: Fri, 6 Jul 2001 18:28:47 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Eric Anderson <anderson@centtech.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: BIGMEM kernel question
In-Reply-To: <3B462AA8.F7F0089D@centtech.com>
Message-ID: <Pine.LNX.4.33L.0107061827430.17825-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2001, Eric Anderson wrote:

> Ahh. That makes sense.  So how can I change the chunk size from
> 64k to something higher (I assume I could set it to 128k to
> effectively double that 3GB to 6GB)?

That won't work.  The address space limitation is a HARDWARE
limitation.

What you _can_ do is put data in shared memory segments, which
you map and unmap on demand. Moving memory management to user
space is the only way to (more or less) get around the 4GB
hardware limitation.

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

