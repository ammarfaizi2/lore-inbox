Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271278AbRINVsT>; Fri, 14 Sep 2001 17:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271309AbRINVsL>; Fri, 14 Sep 2001 17:48:11 -0400
Received: from relay02.cablecom.net ([62.2.33.102]:35593 "EHLO
	relay02.cablecom.net") by vger.kernel.org with ESMTP
	id <S271278AbRINVrw>; Fri, 14 Sep 2001 17:47:52 -0400
Message-Id: <200109142148.f8ELmE517753@mail.swissonline.ch>
Content-Type: text/plain; charset=US-ASCII
From: Christian Widmer <cwidmer@iiic.ethz.ch>
Reply-To: cwidmer@iiic.ethz.ch
To: linux-kernel@vger.kernel.org
Subject: sync syscall/bottom-halves
Date: Fri, 14 Sep 2001 23:48:14 +0200
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

is it right with the following:

A)
 tasklets scheduled by a irq-handler may interrupt 
 1) the request fuction of a block device driver
 2) a open/close system call of a block device driver

B)
 if i don't want to be interrupted by a tasklet i need
 to call local_bh_disable or because (i've to use spin-
 locks anyway) spin_lock_bh.


thank
christian
