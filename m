Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279013AbRKFLU6>; Tue, 6 Nov 2001 06:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279035AbRKFLUp>; Tue, 6 Nov 2001 06:20:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:48260 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S279013AbRKFLUl>;
	Tue, 6 Nov 2001 06:20:41 -0500
Date: Tue, 6 Nov 2001 12:20:33 +0100
From: Jonas Diemer <diemer@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.14 breaks block/loop.c (loopback device)
Message-Id: <20011106122033.30bc844b.diemer@gmx.de>
X-Mailer: Sylpheed version 0.6.3claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The latest kernel seems to breake the loop device. I used 2.4.13 before, and
everything was fine. I didn't change my kernel config when upgrading.

I compile the loop device as a module. trying to modprobe/insmod it, I get the
following error message:

unresolved symbol in loop.o: deactivate_page


I did a 

# grep -R "deactivate_page" * 

in linux-2.4.14: there is no other occurances of deactivate_page in the whole
linux source. 
the patch file shows, that the function "deactivate_page" has been removed
(probably replaced by some similar function). but it seems that nobody updated
loop.c.

I hope you can help

regards
Jonas

PS: As I am not subscribed to the list, please CC me in your answers.


Jonas
