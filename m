Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317179AbSFBNbZ>; Sun, 2 Jun 2002 09:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317178AbSFBNbY>; Sun, 2 Jun 2002 09:31:24 -0400
Received: from [210.78.134.243] ([210.78.134.243]:22544 "EHLO 210.78.134.243")
	by vger.kernel.org with ESMTP id <S317177AbSFBNbX>;
	Sun, 2 Jun 2002 09:31:23 -0400
Date: Sun, 2 Jun 2002 21:22:16 +0800
From: zheng chuanbo <zhengcb@netpower.com.cn>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: some bugs with the bridge in  linux2.4.18?
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-Id: <200206022122193.SM00800@zhengcb>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[the problem]: 
in linux2.4.18,when i use brctl to build the bridge,it works. and the hosts can communicate with the host on the other side of the bridge. but when i tried to stop the bridge with cmd "brctl delif bridge eth0",it always hung there. if i plugged off all the cables,the bridge can also be stopped without any problems.

[tested]:
i tracked the program of brctl,and found that the systems stopped at the following code:
	ioctl(br_socket_fd, SIOCDEVPRIVATE, &ifr);
so i guess the problem is in the ioctl in kernel.
i tested both linux2.4.17 and linux2.4.19pre9, none of them has no such problem.
in linux2.4.19pre1,it works well most of the time,but sometimes it fails. when i check the status with "brctl showstp bridge",if one of the interface shows "blocking",then when try to stop the bridge ,the system also hung there.

so i guess one of the patch solved the problem. which one is it? and what is missed in linux2.4.18? i wish i could find out the answer.

(i don't alway come here,so i wish the answser could be CC to me. thanks.)

chuanbo zheng
zhengcb@netpower.com.cn




