Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbTJWOSR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 10:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263582AbTJWOSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 10:18:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22492 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263580AbTJWOSO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 10:18:14 -0400
Date: Thu, 23 Oct 2003 15:18:12 +0100
From: Matthew Wilcox <willy@debian.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Matt Domsch <Matt_Domsch@dell.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.23-pre8: link error with both megaraid drivers
Message-ID: <20031023141812.GC18370@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0310222116270.1364-100000@logos.cnet> <20031023140743.GF11807@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031023140743.GF11807@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 23, 2003 at 04:07:43PM +0200, Adrian Bunk wrote:
> --- linux-2.4.23-pre7-full/drivers/scsi/Config.in.old	2003-10-11 17:00:47.000000000 +0200
> +++ linux-2.4.23-pre7-full/drivers/scsi/Config.in	2003-10-11 17:24:00.000000000 +0200
> -dep_tristate 'AMI MegaRAID2 support' CONFIG_SCSI_MEGARAID2 $CONFIG_SCSI
> +if [ "$CONFIG_SCSI_MEGARAID" != "y" ]; then
> +  define_tristate CONFIG_SCSI_MEGARAID2_DEP $CONFIG_SCSI
> +else
> +  define_tristate CONFIG_SCSI_MEGARAID2_DEP m $CONFIG_SCSI
> +fi
> +dep_tristate 'AMI MegaRAID2 support' CONFIG_SCSI_MEGARAID2 $CONFIG_SCSI_MEGARAID2_DEP

define_tristate?!  Did you actually try this?

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
