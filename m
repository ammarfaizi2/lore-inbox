Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265002AbSKKM7f>; Mon, 11 Nov 2002 07:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265003AbSKKM7f>; Mon, 11 Nov 2002 07:59:35 -0500
Received: from www2.mail.lycos.com ([209.202.220.150]:37599 "HELO mailcity.com")
	by vger.kernel.org with SMTP id <S265002AbSKKM7e>;
	Mon, 11 Nov 2002 07:59:34 -0500
To: linux-kernel@vger.kernel.org
Date: Mon, 11 Nov 2002 08:05:58 -0500
From: "Paul Richards" <greytek@lycos.com>
Message-ID: <EPBOCLHMEDKLABAA@mailcity.com>
Mime-Version: 1.0
X-Sent-Mail: on
Reply-To: greytek@lycos.com
X-Mailer: MailCity Service
X-Priority: 3
Subject: [PATCH] 2.4.19 rivafb updates
X-Sender-Ip: 68.41.210.181
Organization: Lycos Mail  (http://www.mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides the ability to work with LCDs, bug fixes to cleanup code, Mac support, and support for more nvidia cards. The Mac code was added from a patch Ani Joshi sent me. 

The core of the riva framebuffer driver lies in riva_hw.c, a file from the xfree86 source tree. The original riva_hw.c in 2.4.19 is dated 2/2000, I have updated this file from xfree86's cvs and made the necessary changes to the other source and header files and so the flatpanel code will work properly. Since the riva_hw.c with flatpanel support from xfree86's cvs has not reached an official stable release, this would obviously make this patch experimental. However, the feedback from the xfree86 cvs driver has been good and I've carefully "ported" all the necessary changes over.

Its been tested with DirectFB demo programs called df_stress and df_window on a Pentium3/GeForce2MX with a regular CRT monitor and with a LCD flatpanel that works off a DVI connection. Unless your on a Mac or a notebook with a chipset that works specifically with LCDs like the GeForce2Go, you will most likely have to pass flatpanel=1 to the module when its loading because there is no x86 code yet that looks for DVI flatpanels. There looks to be some code for twinview but I have not had any success with this on my box with xfree86 cvs driver or this new riva framebuffer module. LCDs that use analog connections and hookup to the standard VGA card connections should not need to pass flatpanel=1, this is for digital connections only.

Below is a link to the patch. I have not pasted it because I'm not sure if it will be accepted in the 2.4 branch. I'm also worried that a few of the entries I added in include/linux/pci_ids.h might be to long for some versions of gcc. 
i.e. #define PCI_DEVICE_ID_NVIDIA_GEFORCE4_420_GO_M32 0x0176 
/* largest define I added, 40 characters long */

http://rain.prohosting.com/scftpd/rivafb-richards1.diff.gz

Paul F. Richards



__________________________________________________________
Outgrown your current e-mail service? Get 25MB Storage, POP3 Access,
Advanced Spam protection with LYCOS MAIL PLUS.
http://login.mail.lycos.com/brandPage.shtml?pageId=plus&ref=lmtplus
