Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751664AbWDBD3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbWDBD3x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 22:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbWDBD3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 22:29:53 -0500
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:63135 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751663AbWDBD3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 22:29:53 -0500
Subject: Core-iSCSI/Nokia770 binaries released!
From: "Nicholas A. Bellinger" <nab@kernel.org>
To: Core-iSCSI <Core-iSCSI@googlegroups.com>
Cc: Open iSCSI <open-iscsi@googlegroups.com>,
       iet-dev <iscsitarget-devel@lists.sourceforge.net>,
       maemo-dev <maemo-developers@maemo.org>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 01 Apr 2006 19:22:22 -0800
Message-Id: <1143948142.26951.199.camel@haakon>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all,

A Maemo formatted .deb binary for Core-iSCSI/Nokia770 has been released
on the wiki-homepage at linux-iscsi.org:

http://www.linux-iscsi.org/index.php/Core-iSCSI/Nokia_770

The files can be located directly at:

http://www.linux-iscsi.org/files/core-iscsi-maemo/core-iscsi-maemo-v10_arm.deb
http://www.linux-iscsi.org/files/core-iscsi-maemo/README

The only two requirements that currently exist (as listed in the README)
are 1) bash, and 2) obtaining superuser privledges on the device to be
able to load kernel modules, mount iSCSI LUNs, etc.

The only two limitiations that currently exist are 1) Authentication is
not supported in this release and 2) the 2.6.12.3-omap1 for the 770 does
NOT ship with CONFIG_SCSI_MULTI_LUN=y, and hence we are only able to
detect LUN 0 for each iSCSI Target Node.  Unfortuately scsi_mod is
complied directly the 2.6.12.3-omap1 kernel and the only method to get
around this is recompiling the kernel.  I would like to see scsi_mod
built as a module in future kernel releases for the Nokia 770, and
preferably with CONFIG_SCSI_MULTI_LUN=y enabled.

Also, now that the Core-iSCSI/Nokia770 project has made the first binary
release, its now time to start discussion what the plans are for the
iSCSI UI on the Nokia770.  I will be writing down some ideas for this on
the wiki homepage, and would be interested in getting some feedback on
some of the possibilies for making iSCSI easy to use on small devices.

Have fun!

-- 
Nicholas A. Bellinger <nab@kernel.org>

