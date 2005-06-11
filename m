Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVFKJaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVFKJaP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 05:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVFKJaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 05:30:14 -0400
Received: from shamrock.dyndns.org ([213.146.117.139]:9489 "EHLO
	shamrock.taprogge.wh") by vger.kernel.org with ESMTP
	id S261525AbVFKJ36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 05:29:58 -0400
Date: Sat, 11 Jun 2005 11:29:49 +0200
From: Jens Taprogge <jlt_kernel@shamrock.dyndns.org>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, trusted linux <tcimpl2005@yahoo.com>
Subject: Re: TPM on Thinkpad T43
Message-ID: <20050611092949.GA4507@ranger.taprogge.wh>
Mail-Followup-To: Jens Taprogge <jlt_kernel@shamrock.dyndns.org>,
	Kylene Jo Hall <kjhall@us.ibm.com>, linux-kernel@vger.kernel.org,
	trusted linux <tcimpl2005@yahoo.com>
References: <20050610193802.GA27033@ranger.taprogge.wh> <1118432646.7200.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118432646.7200.24.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 02:44:06PM -0500, Kylene Jo Hall wrote:
> Jens, Gang,
> 
> Thanks, for your very helpful reports.  I have received access to a
> machine with this type and am currently working to get it working.  Jens
> you do have an NSC part but its seems that more has changed.  If you
> want to try further testing for me you can set TPM_NSC_BASE to 0x378 or
> use the version in the -mm patch that reads this value automatically
> instead of setting the value.  Also try removing all calls to
> tpm_write_index in the tpm_nsc_init function.  Either way I'll get back
> to you when we have something working.


Hello Kylie,

2.6.12-rc6-mm1 with the additional PCI IDs gives the following
debugging output (I have added some and made the driver ignore the wrong
SID INDEX):
	tpm_nsc 0000:00:1f.0: NSC TPM base=0xffff
	tpm_nsc 0000:00:1f.0: NSC TPM SID INDEX 0xff
	tpm_nsc 0000:00:1f.0: NSC TPM detected
	tpm_nsc 0000:00:1f.0: NSC LDN 0xff, SID 0xff, SRID 0xff
	tpm_nsc 0000:00:1f.0: NSC SIOCF1 0xff SIOCF5 0xff SIOCF6 0xff SIOCF8 0xff
	tpm_nsc 0000:00:1f.0: NSC IO Base0 0xffff
	tpm_nsc 0000:00:1f.0: NSC IO Base1 0xffff
	tpm_nsc 0000:00:1f.0: NSC Interrupt number and wakeup 0xff
	tpm_nsc 0000:00:1f.0: NSC IRQ type select 0xff
	tpm_nsc 0000:00:1f.0: NSC DMA channel select0 0xff, select1 0xff
	tpm_nsc 0000:00:1f.0: NSC Config 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff
	tpm_nsc 0000:00:1f.0: NSC PC21100 TPM revision 31

If can be of further assistance tracking down the problem, please let me
know.

Best Regards
Jens
