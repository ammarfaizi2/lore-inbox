Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbTEVO62 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 10:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbTEVO62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 10:58:28 -0400
Received: from mailsrv1.sonybpe.com ([62.6.248.15]:32527 "EHLO
	ukbpebasmss01.sonybpe") by vger.kernel.org with ESMTP
	id S261917AbTEVO6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 10:58:24 -0400
Subject: [Fwd: blk_congestion_wait() with linux-2.5.68]
From: Mathew Spencer <Matthew.Spencer@eu.sony.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Content-Type: multipart/mixed; boundary="=-9s+FpjCeSoWattk3EFpF"
Organization: 
Message-Id: <1053617008.8679.280.camel@jeckle>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 22 May 2003 16:23:29 +0100
X-OriginalArrivalTime: 22 May 2003 15:09:17.0859 (UTC) FILETIME=[1D6E9F30:01C32074]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9s+FpjCeSoWattk3EFpF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
I'm forwarding this question to this list as I have been told there is
more expertise here regarding the question.  My usual point of contact
is the linux-arm-kernel mailing list.

Thanks for your time,

Mat Spencer


*************************************************************************
The information contained in this message or any of its
attachments may be privileged and confidential and intended 
for the exclusive use of the addressee. If you are not the
addressee any disclosure, reproduction, distribution or other
dissemination or use of this communication is strictly prohibited
*************************************************************************

--=-9s+FpjCeSoWattk3EFpF
Content-Disposition: inline
Content-Description: Forwarded message - blk_congestion_wait() with
	linux-2.5.68
Content-Type: message/rfc822

Received: from gbisseweymss05.eu.sony.com (43.194.30.211 [43.194.30.211])
	by gbisseweymsx08.eu.sony.com with SMTP (Microsoft Exchange Internet Mail
	Service Version 5.5.2653.13) id KK75FXL7; Thu, 22 May 2003 15:48:54 +0100
Received: from relay1.eu.sony.co.jp (unverified) by
	gbisseweymss05.eu.sony.com (Content Technologies SMTPRS 4.2.10) with ESMTP
	id <T625cf7b82c2bc21e113e0@gbisseweymss05.eu.sony.com> for
	<matthew.spencer@eu.sony.com>; Thu, 22 May 2003 15:48:53 +0100
Received: from www.linux.org.uk (parcelfarce.linux.theplanet.co.uk
	[195.92.249.252]) by relay1.eu.sony.co.jp (8.11.3/8.11.3) with ESMTP id
	h4MEmqV60254 for <matthew.spencer@eu.sony.com>; Thu, 22 May 2003 14:48:53
	GMT
Received: from [127.0.0.1] (helo=parcelfarce.linux.theplanet.co.uk) by
	www.linux.org.uk with esmtp (Exim 4.14) id 19IrLY-0001Om-FO; Thu, 22 May
	2003 15:47:08 +0100
Received: from caramon.arm.linux.org.uk ([212.18.232.186]) by
	www.linux.org.uk with esmtp (TLSv1:DES-CBC3-SHA:168) (Exim 4.14) id
	19IrKy-0001OG-4M for linux-arm-kernel@lists.arm.linux.org.uk; Thu, 22 May
	2003 15:46:32 +0100
Received: from mailsrv1.sonybpe.com ([62.6.248.15]
	helo=ukbpebasmss01.sonybpe) by caramon.arm.linux.org.uk with esmtp (Exim
	4.14) id 19IrKv-0000ug-GD for linux-arm-kernel@lists.arm.linux.org.uk; Thu,
	22 May 2003 15:46:29 +0100
Received: from akombe.bprl.eu.sony.com (unverified) by
	ukbpebasmss01.sonybpe (Content Technologies SMTPRS 4.2.1) with ESMTP id
	<T625cd2cbe12bc2bc21132@ukbpebasmss01.sonybpe> for
	<linux-arm-kernel@lists.arm.linux.org.uk>; Thu, 22 May 2003 15:08:33 +0100
Received: from jeckle ([43.194.41.245]) by akombe.bprl.eu.sony.com with
	Microsoft SMTPSVC(5.0.2195.5329); Thu, 22 May 2003 15:06:24 +0100
Subject: blk_congestion_wait() with linux-2.5.68
From: Mathew Spencer <Matthew.Spencer@eu.sony.com>
To: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1053613235.8669.276.camel@jeckle>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
X-OriginalArrivalTime: 22 May 2003 14:06:25.0140 (UTC)
	FILETIME=[54B76340:01C3206B]
X-For-Lists: true
X-Check-HTML: true
Sender: linux-arm-kernel-admin@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-admin@lists.arm.linux.org.uk
X-BeenThere: linux-arm-kernel@lists.arm.linux.org.uk
X-Mailman-Version: 2.0.11
Precedence: bulk
List-Unsubscribe: 	<http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Id: ARM Linux kernel discussions
	<linux-arm-kernel.lists.arm.linux.org.uk>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: 	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: 	<http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/>
Date: 22 May 2003 15:20:36 +0100
Content-Transfer-Encoding: 7bit

Hi all,
I have been using 2.4.19 successfully for a while now with an PCI IDE
disk drive with no problems whatsoever.  I recently upgraded to 2.5.68
(so that I could use the most recent ieee1394 drivers) and also to start
experimenting with the new version of the kernel and since then I am
having problems formatting the hard disk.

When I run mke2fs, it manages to write out the first 12 or 13 blocks
successfully, but then the code gets stuck continually calling
blk_congestion_wait() from balance_dirty_pages().

This is the only time that I see this problem.  If the disk is already
formatted, then mounting/reading/writing to the disk happens without any
problems at all.

Is anyone out there aware of this problem?
Does anyone know how to fix it?

For your information, I'm using the 2.95.3 toolchain and
linux-2.5.68-rmk1-pxa1.

Your time and knowledge is much appreciated.

Regards,

Mat



*************************************************************************
The information contained in this message or any of its
attachments may be privileged and confidential and intended 
for the exclusive use of the addressee. If you are not the
addressee any disclosure, reproduction, distribution or other
dissemination or use of this communication is strictly prohibited
*************************************************************************

-------------------------------------------------------------------
Subscription options: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ/Etiquette:       http://www.arm.linux.org.uk/armlinux/mailinglists.php

--=-9s+FpjCeSoWattk3EFpF--

