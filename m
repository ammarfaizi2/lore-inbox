Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVGGNcC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVGGNcC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 09:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbVGGN3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 09:29:35 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:39643 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261458AbVGGN3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 09:29:23 -0400
Message-ID: <42CD2E18.40608@us.ibm.com>
Date: Thu, 07 Jul 2005 08:28:56 -0500
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
CC: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Greg KH <greg@kroah.com>, ak@muc.de, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
Subject: Re: [PATCH 3/13]: PCI Err: IPR scsi device driver recovery
References: <20050628235839.GA6362@austin.ibm.com>
In-Reply-To: <20050628235839.GA6362@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas wrote:
> +/** This routine is called when the PCI bus has permanently
> + *  failed.  This routine should purge all pending I/O and
> + *  shut down the device driver (close and unload).
> + *  XXX Needs to be implemented.
> + */
> +static void ipr_eeh_perm_failure (struct pci_dev *pdev)
> +{
> +#if 0  // XXXXXXXXXXXXXXXXXXXXXXX
> +	ipr_cmd->job_step = ipr_reset_shutdown_ioa;
> +	rc = IPR_RC_JOB_CONTINUE;
> +#endif
> +}

What were your plans here? What can the device driver rely on here?
Are interrupts disabled? Will pci config accesses all fail?
Should the driver attempt to talk to the pci adapter at all, or should
it simply clean up after it?


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
