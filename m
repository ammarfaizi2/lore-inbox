Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261338AbSKTPdo>; Wed, 20 Nov 2002 10:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261339AbSKTPdn>; Wed, 20 Nov 2002 10:33:43 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:51590 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261338AbSKTPdn>;
	Wed, 20 Nov 2002 10:33:43 -0500
Date: Wed, 20 Nov 2002 15:38:33 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Andrew Grover <andrew.grover@intel.com>
Subject: Re: Fix S3 resume when kernel is big
Message-ID: <20021120153833.GA4344@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	ACPI mailing list <acpi-devel@lists.sourceforge.net>,
	Andrew Grover <andrew.grover@intel.com>
References: <20021120151136.GA862@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021120151136.GA862@elf.ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 04:11:37PM +0100, Pavel Machek wrote:
 > -	acpi_create_identity_pmd();
 > +	if (!cpu_has_pse) {
 > +		printk(KERN_ERR "You have S3 capable machine without pse? Wow!");
 > +		return 1;
 > +	}

Mobile K6 family never had PSE iirc, and also VIA Cyrix 3's are being
dropped into various laptops.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
