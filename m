Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132830AbRC2UOi>; Thu, 29 Mar 2001 15:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132834AbRC2UO3>; Thu, 29 Mar 2001 15:14:29 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:24345 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S132830AbRC2UOI>;
	Thu, 29 Mar 2001 15:14:08 -0500
Message-ID: <20010329221327.B8791@win.tue.nl>
Date: Thu, 29 Mar 2001 22:13:27 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Aaron Lunansky <alunansky@rim.net>, linux-kernel@vger.kernel.org
Subject: Re: Mount locks on bad ISO image?
In-Reply-To: <A9FD1B186B99D4119BCC00D0B75B4D8107F45925@xch01ykf.rim.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <A9FD1B186B99D4119BCC00D0B75B4D8107F45925@xch01ykf.rim.net>; from Aaron Lunansky on Thu, Mar 29, 2001 at 02:16:03PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2001 at 02:16:03PM -0500, Aaron Lunansky wrote:
> I tried mounting a file as an ISO image (turns out it was corrupted) - after
> running mount file.iso /cdrom -o loop
> mount hung and did not respond.. I could not ^Z it into the background, or
> kill, or kill -9 it...
> 
> I'm certain that I have ISO and loopback support compiled into my kernel.
> 
> Anyone know what might be going on?

Answer 1: in 2.4.2 the loop device does not work
 (but things are better in the -ac patches).
Answer 2: the kernel tends to believe filesystem data,
 and a corrupted filesystem can seriously confuse the kernel.

If you make sure that the problem does not lie in loop
(you can mount other images without problems), then
I wouldnt mind seeing your image (or rather, the first
MB or two of it) to see whether the isofs code must be
improved. (In that case, put some smallish fragment up for ftp
and mail the URL to aeb@cwi.nl. Don't mail cd images.)

Andries
