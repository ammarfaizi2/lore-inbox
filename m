Return-Path: <linux-kernel-owner+w=401wt.eu-S1751996AbXAQDSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbXAQDSa (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 22:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751994AbXAQDSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 22:18:30 -0500
Received: from gate.crashing.org ([63.228.1.57]:35270 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993AbXAQDS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 22:18:28 -0500
Subject: Re: [PATCH 18/59] sysctl: ipmi remove unnecessary insert_at_head
	flag
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "<Andrew Morton" <akpm@osdl.org>, linux-mips@linux-mips.org,
       linux-parport@lists.infradead.org, heiko.carstens@de.ibm.com,
       ak@suse.de, linuxppc-dev@ozlabs.org, paulus@samba.org,
       aharkes@cs.cmu.edu, schwidefsky@de.ibm.com, tim@cyberelk.net,
       rtc-linux@googlegroups.com, linux-scsi@vger.kernel.org,
       kurt.hackel@oracle.com, coda@cs.cmu.edu, vojtech@suse.cz,
       linuxsh-shmedia-dev@lists.sourceforge.net, James.Bottomley@SteelEye.com,
       clemens@ladisch.de, xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       andrea@suse.de, openipmi-developer@lists.sourceforge.net,
       linux-390@vm.marist.edu, codalist@TELEMANN.coda.cs.cmu.edu,
       a.zummo@towertech.it, tony.luck@intel.com,
       linux-ntfs-dev@lists.sourceforge.net, netdev@vger.kernel.org,
       aia21@cantab.net, linux-kernel@vger.kernel.org, ralf@linux-mips.org,
       lethal@linux-sh.org, containers@lists.osdl.org, linux390@de.ibm.com,
       philb@gnu.org
In-Reply-To: <1168965635875-git-send-email-ebiederm@xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
	 <1168965635875-git-send-email-ebiederm@xmission.com>
Content-Type: text/plain
Date: Wed, 17 Jan 2007 14:14:54 +1100
Message-Id: <1169003694.4778.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-16 at 09:39 -0700, Eric W. Biederman wrote:
> From: Eric W. Biederman <ebiederm@xmission.com> - unquoted
> 
> With unique sysctl binary numbers setting insert_at_head is pointless.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  drivers/char/ipmi/ipmi_poweroff.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_poweroff.c b/drivers/char/ipmi/ipmi_poweroff.c
> index 9d23136..b3ae65e 100644
> --- a/drivers/char/ipmi/ipmi_poweroff.c
> +++ b/drivers/char/ipmi/ipmi_poweroff.c
> @@ -686,7 +686,7 @@ static int ipmi_poweroff_init (void)
>  		printk(KERN_INFO PFX "Power cycle is enabled.\n");
>  
>  #ifdef CONFIG_PROC_FS
> -	ipmi_table_header = register_sysctl_table(ipmi_root_table, 1);
> +	ipmi_table_header = register_sysctl_table(ipmi_root_table, 0);
>  	if (!ipmi_table_header) {
>  		printk(KERN_ERR PFX "Unable to register powercycle sysctl\n");
>  		rv = -ENOMEM;

