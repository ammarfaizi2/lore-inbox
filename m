Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVFMO0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVFMO0I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 10:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVFMO0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 10:26:08 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:62954 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261577AbVFMO0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 10:26:02 -0400
Subject: Re: TPM on Thinkpad T43
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Jens Taprogge <jlt_kernel@shamrock.dyndns.org>
Cc: linux-kernel@vger.kernel.org, trusted linux <tcimpl2005@yahoo.com>
In-Reply-To: <20050611092949.GA4507@ranger.taprogge.wh>
References: <20050610193802.GA27033@ranger.taprogge.wh>
	 <1118432646.7200.24.camel@localhost.localdomain>
	 <20050611092949.GA4507@ranger.taprogge.wh>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 09:25:42 -0500
Message-Id: <1118672742.6602.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try redefinig TPM_DATA and TPM_ADDR to 0x2F and 0x2E in tpm.h

Thanks,
Kylie

On Sat, 2005-06-11 at 11:29 +0200, Jens Taprogge wrote:
> On Fri, Jun 10, 2005 at 02:44:06PM -0500, Kylene Jo Hall wrote:
> > Jens, Gang,
> > 
> > Thanks, for your very helpful reports.  I have received access to a
> > machine with this type and am currently working to get it working.  Jens
> > you do have an NSC part but its seems that more has changed.  If you
> > want to try further testing for me you can set TPM_NSC_BASE to 0x378 or
> > use the version in the -mm patch that reads this value automatically
> > instead of setting the value.  Also try removing all calls to
> > tpm_write_index in the tpm_nsc_init function.  Either way I'll get back
> > to you when we have something working.
> 
> 
> Hello Kylie,
> 
> 2.6.12-rc6-mm1 with the additional PCI IDs gives the following
> debugging output (I have added some and made the driver ignore the wrong
> SID INDEX):
> 	tpm_nsc 0000:00:1f.0: NSC TPM base=0xffff
> 	tpm_nsc 0000:00:1f.0: NSC TPM SID INDEX 0xff
> 	tpm_nsc 0000:00:1f.0: NSC TPM detected
> 	tpm_nsc 0000:00:1f.0: NSC LDN 0xff, SID 0xff, SRID 0xff
> 	tpm_nsc 0000:00:1f.0: NSC SIOCF1 0xff SIOCF5 0xff SIOCF6 0xff SIOCF8 0xff
> 	tpm_nsc 0000:00:1f.0: NSC IO Base0 0xffff
> 	tpm_nsc 0000:00:1f.0: NSC IO Base1 0xffff
> 	tpm_nsc 0000:00:1f.0: NSC Interrupt number and wakeup 0xff
> 	tpm_nsc 0000:00:1f.0: NSC IRQ type select 0xff
> 	tpm_nsc 0000:00:1f.0: NSC DMA channel select0 0xff, select1 0xff
> 	tpm_nsc 0000:00:1f.0: NSC Config 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff
> 	tpm_nsc 0000:00:1f.0: NSC PC21100 TPM revision 31
> 
> If can be of further assistance tracking down the problem, please let me
> know.
> 
> Best Regards
> Jens
> 

