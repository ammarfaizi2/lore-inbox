Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129094AbQKCJcb>; Fri, 3 Nov 2000 04:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129118AbQKCJcV>; Fri, 3 Nov 2000 04:32:21 -0500
Received: from alc119.alcatel.be ([195.207.101.119]:53999 "EHLO
	relay1.alcatel.be") by vger.kernel.org with ESMTP
	id <S129094AbQKCJcI>; Fri, 3 Nov 2000 04:32:08 -0500
X-Lotus-FromDomain: ALCATEL
From: Laurent.Kersten@alcatel.be
To: linux-kernel@vger.kernel.org
Message-ID: <C125698C.003444F5.00@bemail04.net.alcatel.be>
Date: Fri, 3 Nov 2000 10:30:54 +0100
Subject: Include file problem with kernel 2.2.16 (seems to be the same
	 with 2.2.17)
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

I've found an unfortunate bug in the "linux/timex.h" file.  This file include "sys/time.h" and this cause any program that use the adjtimex syscall to be unable to compile (You get a lot of multiple definition error message). The only work-around, I've
made is to comment the "#include <sys/time.h>" line and add it  myself in my  (user-mode) program that use the adjtimex syscall.

I would like to know :

1) Is there any side-effect with this ?
2) Is it safe ?



Best regards

Laurent Kersten

Alcatel Bell Space N.V.
Berkenrodelei 33
B-2660 Hoboken.
Tel :     00-32-3-829.54.09
Fax :     00-32-3-829.57.63



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
