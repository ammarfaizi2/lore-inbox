Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262216AbRETUPJ>; Sun, 20 May 2001 16:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262218AbRETUOu>; Sun, 20 May 2001 16:14:50 -0400
Received: from linuxpc1.lauterbach.com ([194.195.165.177]:8256 "HELO
	linuxpc1.lauterbach.com") by vger.kernel.org with SMTP
	id <S262216AbRETUOo>; Sun, 20 May 2001 16:14:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: const __init
Date: Sun, 20 May 2001 22:16:11 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.05.10105202145520.1667-100000@callisto.of.borg>
In-Reply-To: <Pine.LNX.4.05.10105202145520.1667-100000@callisto.of.borg>
MIME-Version: 1.0
Message-Id: <01052022161101.02140@enzo.bigblue.local>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 May 2001 21:51, Geert Uytterhoeven wrote:
> Since a while include/linux/init.h contains the line
>
>     * Also note, that this data cannot be "const".
>
> Why is this? Because const data will be put in a different section?

Yes, and gcc3 errors on these constructs,  cause it cannot decide if the data 
should be put into a .data or .rodata section.
Dunno if it's worth to create a __initconstdata/__initrodata though, but it 
would be easy implement I guess.

>     drivers/video/aty128fb.c

Fixed in bk 2_4.

Franz.
