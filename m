Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbSKTPmV>; Wed, 20 Nov 2002 10:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261370AbSKTPmV>; Wed, 20 Nov 2002 10:42:21 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:10882 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261368AbSKTPmT>; Wed, 20 Nov 2002 10:42:19 -0500
Subject: Re: Fix S3 resume when kernel is big
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Andrew Grover <andrew.grover@intel.com>
In-Reply-To: <20021120153833.GA4344@suse.de>
References: <20021120151136.GA862@elf.ucw.cz> 
	<20021120153833.GA4344@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Nov 2002 16:17:35 +0000
Message-Id: <1037809055.3702.43.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-20 at 15:38, Dave Jones wrote:
> On Wed, Nov 20, 2002 at 04:11:37PM +0100, Pavel Machek wrote:
>  > -	acpi_create_identity_pmd();
>  > +	if (!cpu_has_pse) {
>  > +		printk(KERN_ERR "You have S3 capable machine without pse? Wow!");
>  > +		return 1;
>  > +	}
> 
> Mobile K6 family never had PSE iirc, and also VIA Cyrix 3's are being
> dropped into various laptops.

Plenty of desktop machines have S3 

