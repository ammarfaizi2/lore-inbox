Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVAXQPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVAXQPK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 11:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVAXQPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 11:15:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36044 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261301AbVAXQPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 11:15:02 -0500
Date: Mon, 24 Jan 2005 16:14:56 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Andi Kleen <ak@suse.de>
Cc: Anton Blanchard <anton@samba.org>, Matthew Wilcox <matthew@wil.cx>,
       akpm@osdl.org, paulus@samba.org, tony.luck@intel.com,
       ralf@linux-mips.org, schwidefsky@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Problems disabling SYSCTL
Message-ID: <20050124161456.GK31455@parcelfarce.linux.theplanet.co.uk>
References: <20050123050102.GD5920@krispykreme.ozlabs.ibm.com> <20050123143500.GC31455@parcelfarce.linux.theplanet.co.uk> <20050123191743.GB6784@wotan.suse.de> <20050124135001.GC27258@krispykreme.ozlabs.ibm.com> <20050124160053.GB29950@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124160053.GB29950@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 05:00:53PM +0100, Andi Kleen wrote:
> But seriously I wouldn't bother - the syscall interface is deprecated anyways
> and has been for a long time. The only sysctl that needs to be handled
> is (CTL_KERN,KERN_VERSION) [used by glibc], the others are not needed
> and I hoep to eventually remove them even natively.
> 
> -Andi
> 
> P.S.: Andrew I just discovered you removed the printk code for this.
> That's not good, how are users supposed to know it's deprecated?

How are kernel hackers to know it's been deprecated?  ;-)

Index: Documentation/feature-removal-schedule.txt
===================================================================
RCS file: /var/cvs/linux-2.6/Documentation/feature-removal-schedule.txt,v
retrieving revision 1.2
diff -u -p -r1.2 feature-removal-schedule.txt
--- Documentation/feature-removal-schedule.txt  12 Jan 2005 20:14:53 -0000     1.2
+++ Documentation/feature-removal-schedule.txt  24 Jan 2005 16:13:54 -0000
@@ -32,3 +32,11 @@ Why: /proc/sys/cpu/* has been deprecated
        /sys/devices/system/cpu/cpu%n/cpufreq/.
 Who:   Dominik Brodowski <linux@brodo.de>
 
+---------------------------
+
+What:  The sysctl() syscall
+When:  January 2006
+Files: kernel/sysctl.c
+Why:   Dunno.
+Who:   Andi Kleen <ak@suse.de>
+

Want to finish it off and send it to Andrew?  ;-)

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
