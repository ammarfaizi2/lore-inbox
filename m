Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265178AbSKFAMV>; Tue, 5 Nov 2002 19:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265180AbSKFAMV>; Tue, 5 Nov 2002 19:12:21 -0500
Received: from sdsl-64-139-1-6.dsl.sca.megapath.net ([64.139.1.6]:30924 "EHLO
	BOSSW2K.plustream.com") by vger.kernel.org with ESMTP
	id <S265178AbSKFAMR> convert rfc822-to-8bit; Tue, 5 Nov 2002 19:12:17 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
content-class: urn:content-classes:message
Subject: RE2: [Evms-devel] EVMS announcement
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Tue, 5 Nov 2002 16:18:53 -0800
Message-ID: <CC9E5302F1C5704A9685A21E54DA277B16F5CE@BOSSW2K.plustream.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RE2: [Evms-devel] EVMS announcement
Thread-Index: AcKFH158ZwCKCH2oS0aYKNurpi4GqgABkxrQ
From: "Michael Nguyen" <michael.nguyen@corosoft.com>
To: "Kevin Corry" <corryk@us.ibm.com>, <evms-devel@lists.sourceforge.net>,
       <evms-announce@lists.sourceforge.net>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is one sad :( email to read, and Im sure it's
even more difficult to write. There can't be any winner
when public domain refuses a given work. I commend your 
past and your continuing development effort.

Near term:
1. How long will EVMS1.2.0 & kernel2.4 be supported?

Looking further out:
1. Is EVMS runtime a throw away?
2. Is EVMS engine to modify for LVM2 support?
3. What will happen to the modular (plugins)?
     - AIX LVM
     - OS2 LVM
     - Device manager (local/san)
     - etc..

Thanks,
Michael.



> -----Original Message-----
> From: Kevin Corry [mailto:corryk@us.ibm.com] 
> Sent: Tuesday, November 05, 2002 2:19 PM
> To: evms-devel@lists.sourceforge.net; 
> evms-announce@lists.sourceforge.net
> Cc: linux-kernel@vger.kernel.org
> Subject: [Evms-devel] EVMS announcement
> 
> 
> Greetings EVMS users,
> 
> On behalf of the EVMS team, we would like to announce a 
> significant change in direction for the Enterprise Volume 
> Management System project.
> 
> As many of you may know by now, the 2.5 kernel feature freeze 
> has come and gone, and it seems clear that the EVMS kernel 
> driver is not going to be included. With this in mind, we 
> have decided to rework the EVMS user-space administration 
> tools (the Engine) to work with existing drivers currently in 
> the kernel, including (but not necessarily limited
> to) device mapper and MD.
> 
> Why make this change? With EVMS being passed over for 
> inclusion in 2.5, the future of the EVMS kernel driver 
> becomes very uncertain. We could obviously continue working 
> on it and keep it up-to-date as a patch against the latest 
> kernels. Numerous helpful comments and changes were suggested 
> during the review of the code last month on the kernel 
> mailing list. We could spend the time to make many of the 
> desired fixes, including some architectural and interface 
> changes. However, the one issue that has not been addressed 
> at length is EVMS's in-kernel volume discovery mechanism.  We 
> believe that even if the other changes are made, this will 
> eventually become an issue at a later time. Moving discovery 
> to user-space is certainly a possibility. However, at that 
> point, it would become difficult to differentiate the EVMS 
> driver from the device mapper driver, since they would be 
> performing very similar tasks.
> 
> In addition, there would be no need to maintain duplicate MD 
> kernel code in order to provide compatibility with existing 
> software RAID devices.  Obviously this duplication has been a 
> significant issue, but it was an unfortunate necessity in 
> order for MD devices to be discovered within the current EVMS 
> kernel framework. With discovery moving to user-space, the 
> EVMS tools can simply be rewritten to communicate with the 
> existing MD driver in the kernel. This approach allows MD to 
> be used directly, without requiring it to be immediately 
> ported to device mapper. However, if the decision is made in 
> the future to make that port, then the EVMS tools should only 
> become simpler.
> 
> We will also emphasize that this change has not been made 
> suddenly or without a great deal of thought. We have been 
> contemplating this possibility since shortly after the Ottawa 
> Linux Symposium in July. However, we continued to develop the 
> EVMS kernel driver because of input from our users. We wanted 
> to go ahead and submit the driver and get the opinion of the 
> full community before making this decision. In the last few 
> weeks it has become clear that the current EVMS approach is 
> not what the kernel community was looking for, so we have 
> spent that time determining the feasibility and consequences 
> of making this switch. We have come up with a good initial 
> plan, and everyone involved now agrees that this is the best 
> course of action.
> 
> So how will this switch affect the EVMS users? Ideally, we 
> want the users' experience with EVMS to remain completely 
> unchanged. Based on our current plans, the user interfaces 
> will not have to change at all, since we don't see any major 
> changes to the Engine's external application interface. The 
> plan is to provide the same, single, coherent method for 
> performing all volume management tasks. This change will be 
> almost transparent for most users. The same features, 
> plugins, and capabilities will be supported.
> 
> There will, of course, be some minor changes. Specifically, 
> installing EVMS will be slightly different. It will involve 
> different kernel options than you are used to with the 
> current version. In the 2.5 kernel, all of the major 
> components are already present, so little, if any, kernel 
> patching should be necessary. Since device mapper has not yet 
> been included in the main 2.4 kernel, 2.4 users will still 
> require kernel patches. In addition, some functionality still 
> does not exist in any of the available drivers. Specifically, 
> we may provide extra device mapper modules for features like 
> bad block relocation. The installation of the EVMS engine 
> tools, on the other hand, should not change significantly 
> from the current method.
> 
> The other major difference will be due to the move to 
> user-space discovery. First of all, why make this switch? The 
> most obvious reason is that the kernel drivers become much 
> simpler, and the only things they need to provide is I/O 
> handling and a method for activating the volumes. While disk 
> partitioning and software RAID still perform discovery in the 
> kernel, the trend seems to be to move these tasks to 
> user-space. It is likely at some point in the future that 
> partitioning and MD will also be moved out of the kernel as 
> well. However, the drawback to making this switch is losing 
> automatic boot-time volume discovery. Activating EVMS volumes 
> will now require a call to a user-space utility, which will 
> need to be added to the system's init scripts in order to 
> activate the volumes on each boot.
> 
> In addition, this switch complicates having the root 
> filesystem on an EVMS volume. Currently there is a lot of 
> work being done on adding initramfs to the 2.5 kernel, which 
> will provide a pre-root-fs user-space. This new system should 
> provide a simple method for adding tasks to run during this 
> early user-space, and those who wish to use root-on-EVMS will 
> just need to add the EVMS tools to their initramfs. For 2.4 
> users, this means using an initial ramdisk (initrd) to 
> provide this same pre-root user-space. Initrd setup is 
> certainly awkward and often distribution- specific. But we 
> will do our best to provide adequate instructions and 
> assistance to those who need help in that situation.
> 
> Looking ahead, we *will* continue to *fully* support the 
> 1.2.0 version of EVMS on 2.4 kernels, and possibly release a 
> 1.2.1 version with some recent bug fixes. We will also make a 
> reasonable effort to maintain the current EVMS kernel driver 
> on 2.5. It will not go through any other major changes, but 
> we will try to keep it up-to-date and working with the latest 
> 2.5 releases, until the new EVMS tools are complete. At that 
> point, the 2.5 EVMS driver will be dropped. Also, the new 
> enhancements we have been working on recently, such as 
> clustering and volume move, will only be developed under the 
> new Engine model, and will not be available for the current 
> 1.2.x code base.
> 
> So how long will this take? Currently, we are estimating that 
> we can have the user-space volume activation framework 
> working, along with initial support for most of the plugins, 
> by early 2003. Certain features, such as BBR and 
> Snapshotting, may take longer to work out the details of 
> their operation. We will soon open a new CVS tree to hold the 
> new Engine code, leaving the old trees as a repository for 
> bug fixes to the 1.2.x version.
> 
> In summary, we feel that this decision is the best way to 
> support our users for the long term. We want to provide EVMS 
> on current and future kernels, and we feel this change 
> provides the best method for achieving that. At the same 
> time, this addresses all of the concerns voiced by the kernel 
> community.  If anyone has any questions or concerns about 
> this decision, please email us or the EVMS mailing list at 
> evms-devel@lists.sf.net. We will be happy to answer any 
> questions or discuss these changes in more detail.
> 
> Thank you,
> 
> The EVMS Team
> http://evms.sourceforge.net/
> evms-devel@lists.sourceforge.net
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: See the NEW Palm 
> Tungsten T handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
_______________________________________________
Evms-devel mailing list
Evms-devel@lists.sourceforge.net
To subscribe/unsubscribe, please visit:
https://lists.sourceforge.net/lists/listinfo/evms-devel
