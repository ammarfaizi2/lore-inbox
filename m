Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWC2TwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWC2TwZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 14:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbWC2TwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 14:52:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47005 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750885AbWC2TwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 14:52:24 -0500
Date: Wed, 29 Mar 2006 14:52:12 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Paul Mackerras <paulus@samba.org>,
       Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Move pSeries firmware feature setup into platforms/pseries
Message-ID: <20060329195212.GA19236@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <michael@ellerman.id.au>
References: <200603230714.k2N7EmH1021685@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603230714.k2N7EmH1021685@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 07:14:49AM +0000, Linux Kernel wrote:
 > commit 1965746bce49ddf001af52c7985e16343c768021
 > tree d311fce31613545f3430582322d66411566f1863
 > parent 0941d57aa7034ef7010bd523752c2e3bee569ef1
 > author Michael Ellerman <michael@ellerman.id.au> Fri, 10 Feb 2006 15:47:36 +1100
 > committer Paul Mackerras <paulus@samba.org> Fri, 10 Feb 2006 16:52:03 +1100
 > 
 > [PATCH] powerpc: Move pSeries firmware feature setup into platforms/pseries
 > 
 > Currently we have some stuff in firmware.h and kernel/firmware.c that is
 > #ifdef CONFIG_PPC_PSERIES. Move it all into platforms/pseries.

This (or one of the other firmware patches, I've not narrowed it down that close)
breaks ppc64 oprofile.

modpost now complains with..

kernel/arch/powerpc/oprofile/oprofile.ko needs unknown symbol ppc64_firmware_features

		Dave

-- 
http://www.codemonkey.org.uk
