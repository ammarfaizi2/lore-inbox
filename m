Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279243AbRKIJZ4>; Fri, 9 Nov 2001 04:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279749AbRKIJZq>; Fri, 9 Nov 2001 04:25:46 -0500
Received: from [194.213.32.133] ([194.213.32.133]:30337 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S279722AbRKIJZh>;
	Fri, 9 Nov 2001 04:25:37 -0500
Date: Fri, 9 Nov 2001 10:21:41 +0100
From: root <root@Elf.ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: serial console slow
Message-ID: <20011109102140.A29288@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

> I tried to boot my kernel using the serial console, using the
> console=ttyS0,115200 (it does the same thing with 9600) ... it work great
> until :
> 
> Freeing unused kernel memory: 36k freed
> serial console detected.  Disabling virtual terminals.
> console=/dev/ttyS0
> 
> At this point the output of the serial line slow down dramaticly ... almost
> to a halt ... I get 1 line every 30 seconds !!!
> 
> why is this slow down occuring ? the part which is 100% kernel is going fast
> and ok, but when it become console related ... it slows down ?

Serial just got its control signals (it is now *userland* writing, and
userland honours them), plus userland is  probably opening/closing
serial all the time. Bad.
									Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.




----- End forwarded message -----

-- 
--
I'm really pavel@atrey.karlin.mff.cuni.cz. 	   Pavel
Look at http://atrey.karlin.mff.cuni.cz/~pavel ;-).
