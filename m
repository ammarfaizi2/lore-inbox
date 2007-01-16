Return-Path: <linux-kernel-owner+w=401wt.eu-S1751290AbXAPWQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbXAPWQI (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 17:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbXAPWQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 17:16:07 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:52897 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbXAPWQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 17:16:06 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 45/59] sysctl: C99 convert ctl_tables in drivers/parport/procfs.c
Date: Tue, 16 Jan 2007 23:15:43 +0100
User-Agent: KMail/1.9.5
Cc: "<Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       containers@lists.osdl.org, netdev@vger.kernel.org,
       xfs-masters@oss.sgi.com, xfs@oss.sgi.com, linux-scsi@vger.kernel.org,
       James.Bottomley@steeleye.com, minyard@acm.org,
       openipmi-developer@lists.sourceforge.net, tony.luck@intel.com,
       linux-mips@linux-mips.org, ralf@linux-mips.org, schwidefsky@de.ibm.com,
       heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-390@vm.marist.edu,
       paulus@samba.org, linuxppc-dev@ozlabs.org, lethal@linux-sh.org,
       linuxsh-shmedia-dev@lists.sourceforge.net, ak@suse.de, vojtech@suse.cz,
       clemens@ladisch.de, a.zummo@towertech.it, rtc-linux@googlegroups.com,
       linux-parport@lists.infradead.org, andrea@suse.de, tim@cyberelk.net,
       philb@gnu.org, aharkes@cs.cmu.edu, coda@cs.cmu.edu,
       codalist@telemann.coda.cs.cmu.edu, aia21@cantab.net,
       linux-ntfs-dev@lists.sourceforge.net, mark.fasheh@oracle.com,
       kurt.hackel@oracle.com
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com> <11689656733768-git-send-email-ebiederm@xmission.com>
In-Reply-To: <11689656733768-git-send-email-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701162315.56454.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Tuesday, 16. January 2007 17:39, Eric W. Biederman wrote:
> diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
> index 2e744a2..5337789 100644
> --- a/drivers/parport/procfs.c
> +++ b/drivers/parport/procfs.c
> @@ -263,50 +263,118 @@ struct parport_sysctl_table {
> +		{
> +			.ctl_name	= DEV_PARPORT_BASE_ADDR,
> +			.procname	= "base-addr",
> +			.data		= NULL,
> +			.maxlen		= 0,
> +			.mode		= 0444,
> +			.proc_handler	= &do_hardware_base_addr
> +		},

No need to initialize to zero or NULL. Just list any variable, which is NOT zero or NULL.

> +		{
> +			.ctl_name	= DEV_PARPORT_AUTOPROBE + 1,
> +			.procname	= "autoprobe0",
> +			.data		= NULL,
> +			.maxlen		= 0,
> +			.maxlen		= 0444,
> +			.proc_handler	=  &do_autoprobe
> +		},

Typo here? .mode = 0444 makes mor sense.

Regards

Ingo Oeser
