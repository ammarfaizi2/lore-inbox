Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267671AbUBRTGs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 14:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267738AbUBRTGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 14:06:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32137 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267671AbUBRTGp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 14:06:45 -0500
Date: Wed, 18 Feb 2004 19:06:37 +0000
From: Matthew Wilcox <willy@debian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: ramon.rey@hispalinux.es, rrey@ranty.pantax.net,
       linux-kernel@vger.kernel.org, Matthew Wilcox <willy@debian.org>
Subject: Re: 2.6.3-mm1
Message-ID: <20040218190637.GO11824@parcelfarce.linux.theplanet.co.uk>
References: <20040217232130.61667965.akpm@osdl.org> <1077114386.12206.2.camel@debian> <20040218105555.17cc7bba.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218105555.17cc7bba.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 10:55:55AM -0800, Andrew Morton wrote:
> Ramon Rey Vicente <rrey@ranty.pantax.net> wrote:
> >
> > Hi,
> > 
> > With ACPI disabled and APM enabled I get this build error.
> > 
> > arch/i386/kernel/built-in.o(.text+0xbf3a): In function `acpi_apic_setup':
> > : undefined reference to `smp_found_config'
> > arch/i386/kernel/built-in.o(.text+0xbf43): In function `acpi_apic_setup':
> > : undefined reference to `clustered_apic_check'
> > make: *** [.tmp_vmlinux1] Error 1
> 
> The fickle finger of fate points at expanded-pci-config-space.patch

It does indeed.  The patch I posted earlier today
(http://www.ussg.iu.edu/hypermail/linux/kernel/0402.2/0770.html) fixes it.
I've got some more updates for this patch coming shortly, BTW.  If anyone
wants a quick workaround, you can just turn on Local APIC and the problem
will disappear.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
