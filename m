Return-Path: <linux-kernel-owner+w=401wt.eu-S1752415AbXAAAH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415AbXAAAH0 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 19:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754605AbXAAAH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 19:07:26 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:48419 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbXAAAHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 19:07:25 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 4/8] KVM: Implement a few system configuration msrs
Date: Mon, 1 Jan 2007 01:07:14 +0100
User-Agent: KMail/1.9.5
Cc: kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mingo@elte.hu
References: <45939755.7010603@qumranet.com> <20061228101117.65A392500F7@il.qumranet.com>
In-Reply-To: <20061228101117.65A392500F7@il.qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701010107.18008.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 28. December 2006 11:11, Avi Kivity wrote:
> Index: linux-2.6/drivers/kvm/svm.c
> ===================================================================
> --- linux-2.6.orig/drivers/kvm/svm.c
> +++ linux-2.6/drivers/kvm/svm.c
> @@ -1068,6 +1068,9 @@ static int emulate_on_interception(struc
>  static int svm_get_msr(struct kvm_vcpu *vcpu, unsigned ecx, u64 *data)
>  {
>  	switch (ecx) {
> +	case 0xc0010010: /* SYSCFG */
> +	case 0xc0010015: /* HWCR */
> +	case MSR_IA32_PLATFORM_ID:
>  	case MSR_IA32_P5_MC_ADDR:
>  	case MSR_IA32_P5_MC_TYPE:
>  	case MSR_IA32_MC0_CTL:

What about just defining constants for these?
Then you can rip out these comments.

Same for linux-2.6/drivers/kvm/vmx.c


Regards

Ingo Oeser
