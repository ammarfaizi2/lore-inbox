Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314961AbSENBWv>; Mon, 13 May 2002 21:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314975AbSENBWu>; Mon, 13 May 2002 21:22:50 -0400
Received: from zok.SGI.COM ([204.94.215.101]:37805 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S314961AbSENBWs>;
	Mon, 13 May 2002 21:22:48 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Strange s390 code in 2.4.19-pre8 
In-Reply-To: Your message of "Mon, 13 May 2002 12:19:33 -0400."
             <20020513121933.A6208@devserv.devel.redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 May 2002 11:22:11 +1000
Message-ID: <5610.1021339331@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2002 12:19:33 -0400, 
Pete Zaitcev <zaitcev@redhat.com> wrote:
>It would work if EXPORT_SYMBOL_NOVERS were involved.

EXPORT_SYMBOL_NOVERS should only be used when the symbol is used in
assembler.  Asm code does not get the modversion name mangling.  If you
have to use EXPORT_SYMBOL_NOVERS for symbols in C code there is almost
ceratinly something wrong.

