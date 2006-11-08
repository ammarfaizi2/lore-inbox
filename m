Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWKHWQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWKHWQq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932790AbWKHWQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:16:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16814 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932075AbWKHWQo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:16:44 -0500
Date: Wed, 8 Nov 2006 17:16:26 -0500
From: Dave Jones <davej@redhat.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gx-suspmod: fix "&& 0xff" typo
Message-ID: <20061108221626.GH3309@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@osdl.org>, Dave Jones <davej@codemonkey.org.uk>,
	linux-kernel@vger.kernel.org
References: <20061108220435.GA4972@martell.zuzino.mipt.ru> <20061108141007.e0adf333.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061108141007.e0adf333.randy.dunlap@oracle.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 02:10:07PM -0800, Randy Dunlap wrote:
 > On Thu, 9 Nov 2006 01:04:35 +0300 Alexey Dobriyan wrote:
 > 
 > > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
 > > ---
 > > 
 > >  arch/i386/kernel/cpu/cpufreq/gx-suspmod.c |    2 +-
 > >  1 file changed, 1 insertion(+), 1 deletion(-)
 > > 
 > > --- a/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c
 > > +++ b/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c
 > > @@ -473,7 +473,7 @@ static int __init cpufreq_gx_init(void)
 > >  	pci_read_config_byte(params->cs55x0, PCI_MODON, &(params->on_duration));
 > >  	pci_read_config_byte(params->cs55x0, PCI_MODOFF, &(params->off_duration));
 > >          pci_read_config_dword(params->cs55x0, PCI_CLASS_REVISION, &class_rev);
 > > -	params->pci_rev = class_rev && 0xff;
 > > +	params->pci_rev = class_rev & 0xff;
 > 
 > Hi,
 > any kind of automated detection on that one?

grep -r "&& 0x" .  seems to be pretty effective modulo
some false-positives.

		Dave

-- 
http://www.codemonkey.org.uk
