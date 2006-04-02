Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWDBFVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWDBFVq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 00:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWDBFVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 00:21:46 -0500
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:32613 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751128AbWDBFVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 00:21:45 -0500
Subject: Re: Core-iSCSI/Nokia770 binaries released!
From: "Nicholas A. Bellinger" <nab@kernel.org>
To: Core-iSCSI <Core-iSCSI@googlegroups.com>
Cc: Open iSCSI <open-iscsi@googlegroups.com>,
       iet-dev <iscsitarget-devel@lists.sourceforge.net>,
       maemo-dev <maemo-developers@maemo.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1143948142.26951.199.camel@haakon>
References: <1143948142.26951.199.camel@haakon>
Content-Type: text/plain
Date: Sat, 01 Apr 2006 21:14:14 -0800
Message-Id: <1143954854.26951.206.camel@haakon>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A quick followup..

On Sat, 2006-04-01 at 19:22 -0800, Nicholas A. Bellinger wrote:

> 
> The only two limitiations that currently exist are 1) Authentication is
> not supported in this release and 2) the 2.6.12.3-omap1 for the 770 does
> NOT ship with CONFIG_SCSI_MULTI_LUN=y, and hence we are only able to
> detect LUN 0 for each iSCSI Target Node.  Unfortuately scsi_mod is
> complied directly the 2.6.12.3-omap1 kernel and the only method to get
> around this is recompiling the kernel.  I would like to see scsi_mod
> built as a module in future kernel releases for the Nokia 770, and
> preferably with CONFIG_SCSI_MULTI_LUN=y enabled.
> 

Patrick Mansfield mentioned that the following will fix limitiation #2
mentioned above:

echo 512 > /sys/module/scsi_mod/parameters/max_luns

This applies to other vendor's kernels as well, so I will go ahead and
made sure that this is set correctly when /etc/init.d/initiator is
started.  I will put a new .deb up shortly, as well as include this into
the next release of core-iscsi-tools.

Thanks again Patrick!

-- 
Nicholas A. Bellinger <nab@kernel.org>

