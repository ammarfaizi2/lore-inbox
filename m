Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264468AbUDVQe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264468AbUDVQe6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 12:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264513AbUDVQe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 12:34:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:23246 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264468AbUDVQez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 12:34:55 -0400
Date: Thu, 22 Apr 2004 09:28:53 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Kieran <kieran@ihateaol.co.uk>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       jejb <james.bottomley@steeleye.com>
Subject: Re: Why is CONFIG_SCSI_QLA2X_X always enabled?
Message-Id: <20040422092853.55d0b011.rddunlap@osdl.org>
In-Reply-To: <4087E95F.5050409@ihateaol.co.uk>
References: <4087E95F.5050409@ihateaol.co.uk>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2004 16:48:47 +0100 Kieran wrote:

| This has been bugging me for a while.. on pretty much all 2.6 kernel 
| configs I've done, the .config has had CONFIG_SCSI_QLA2XXX=y in it, 
| regardless of whether or not I have any other SCSI stuff compiled in. Is 
| there a reason for this, or is it a bug?

A nuisance or annoyance perhaps.  Here's a patch for it.


// linux-266-rc2
// Make SCSI_QLA2XXX config option changeable/selectable

diffstat:=
 drivers/scsi/qla2xxx/Kconfig |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)


diff -Naurp ./drivers/scsi/qla2xxx/Kconfig~scsi_qla2 ./drivers/scsi/qla2xxx/Kconfig
--- ./drivers/scsi/qla2xxx/Kconfig~scsi_qla2	2004-04-20 15:54:24.000000000 -0700
+++ ./drivers/scsi/qla2xxx/Kconfig	2004-04-22 09:39:03.000000000 -0700
@@ -1,6 +1,5 @@
 config SCSI_QLA2XXX
-	tristate
-	default (SCSI && PCI)
+	tristate "Configure QLogic 21xx/22xx/23xx/63xx host adapters"
 	depends on SCSI && PCI
 
 config SCSI_QLA21XX
