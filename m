Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272529AbTHKM55 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 08:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272536AbTHKM55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 08:57:57 -0400
Received: from netc-4v.grolier.fr ([194.158.97.228]:58065 "EHLO
	netc-4v.grolier.fr") by vger.kernel.org with ESMTP id S272529AbTHKM54 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 08:57:56 -0400
From: ramzez@netcourrier.com
To: linux-kernel@vger.kernel.org
Subject: [ Problem with mm-tree of test2/test3 ] The size of /lib/modules is too big
Date: Mon, 11 Aug 2003 14:57:02 CEST
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet2.1060606622.13214.ramzez@netcourrier.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I hope this is the right place to report this problem I noticed. If not, don't care about it.

Since 2.6-test1 has been released, I test the kernel and its mm patch
yesterday, I noticed that the directory in /lib/modules are very big
I look for what is the cause and, after some test, I concluded that this is mm patch who increase the kernel modules size
the test1 had no problem
the test2, test2-mm1, test2-mm2 and test3 had no size problem
but test2-mm3, test2-mm5 and test3-mm1 have a very big related directory in /lib/modules/
with nearly the same kernel config, the size of directories which have no problem is 4MB
and the size of directories which seems to have a size problem is 20-25MB
I think something wrong has been added in these patch between test2-mm2 and test2-mm3

To be sure, I made the test with EXACTLY the same config with test3 and test3-mm1
size of modules directory of test3 was 3MB
for test3-mm1, it was 14MB
and when I look in these directory, I found some strange things :
size of directory of reseirfs in test3 is 244KB
in test3-mm1 : 2.3MB
all others modules seems to have the same size difference

I repeat that I use exactly the same way to compile the two kernel

-------------------------------------------------------------
NetCourrier, votre bureau virtuel sur Internet : Mail, Agenda, Clubs, Toolbar...
Web/Wap : www.netcourrier.com
Téléphone/Fax : 08 92 69 00 21 (0,34 € TTC/min)
Minitel: 3615 NETCOURRIER (0,15 € TTC/min)

