Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbUC3OUh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 09:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263668AbUC3OUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 09:20:37 -0500
Received: from mimesweeper2.hubbell.com ([63.111.141.185]:52234 "EHLO
	cprorgctnt02-ms.hubbell.com") by vger.kernel.org with ESMTP
	id S263665AbUC3OUb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 09:20:31 -0500
Message-Id: <s0693be0.086@CRPORGCTNW02-IA>
X-Mailer: Novell GroupWise Internet Agent 6.0.2
Date: Tue, 30 Mar 2004 09:17:54 -0500
From: "Brian T. Brunner" <brian.t.brunner@gai-tronics.com>
To: <greg@kroah.com>, <linux-hotplug-devel@lists.sourceforge.net>,
       <linux-usb-devel@lists.sourceforge.net>,
       <Linux-usb-users@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-usb-users] [ANNOUNCE] 2004-03-29 release of hotplug
    scripts
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks, Greg, for the dedication.

I'll do some testing of this from a "truly dumb user" perspective.

Brian Brunner
brian.t.brunner@gai-tronics.com
(610)796-5838

>>> Greg KH <greg@kroah.com> 03/29/04 08:31PM >>>
I've just packaged up the latest Linux hotplug scripts into a release,
which can be found at:
 	http://sourceforge.net/project/showfiles.php?group_id=17679 
 
Or from your favorite kernel.org mirror at:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2004_03_29.tar.gz
or for those who like bz2 packages:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2004_03_29.tar.bz2

I've also packaged up some pre-built (and signed) Red Hat FC 2-test based rpms:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2004_03_29-1.noarch.rpm
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-base-2004_03_29-1.noarch.rpm

The source rpm is available if you want to rebuild it for other distros
or versions of Red Hat at:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2004_03_29-1.src.rpm
 
The main web site for the linux-hotplug project can be found at:
	http://linux-hotplug.sf.net/ 
which contains lots of documentation on the whole linux-hotplug
process.

This release is recommended for _anyone_ using older versions of the
hotplug scripts (especially the last development snapshot) as lots of
bugs have been fixed.  Especially for any scsi or usb-storage users, now
the proper drivers should be automatically loaded when a device is
plugged in.

The release is still backwards compatible with 2.4, so there is no need
to worry about upgrading.

The full ChangeLog extract since the last release is included below for
those who want to know everything that's been changed, and who to blame
for them :)

Many thanks to everyone who has send in patches for this release,
without these submissions, this release would still contain lots of
issues...


thanks,

greg k-h

Mon Mar 29 2004 kroah
        - 2004_03_29 release
        - make test on network start for /var/... a Red Hat specific test
        - make modprobe use '-q' to get rid of some unneeded messages at
          times.  Reported by upstream users at:
                http://bugs.gentoo.org/show_bug.cgi?id=37086 

Sat Mar 27 2004 ukai

        - usb.rc: fix usb coldplugging on linux 2.6.*
                  sleep to wait usb data propagated at usb boot

Fri Mar 26 2004 kroah
        - more messages quieted (in scsi.agent this time.)
        - make "... no modules for..." messages not print out except if
          debugging is enabled.
        - From Jean Tourrilhes <jt@bougret.hpl.hp.com>:
                add support for ifrename if present.
        - From Stephen Hemminger <shemminger@osdl.org>:
                add stir4200 to the usb.distmap file.
        - From Rolf Eike Beer <eike-hotplug@sf-tec.de>:
                fix detection of kernel series for older machines with no USB
                or PCI busses.

Mon Mar 15 2004 ukai
        - firmware.agent: quote firmware name
        - usb.agent: sysfs usb attribute value is hex
        - scsi.agent: remove bashism
        - input.rc: do not even try if /proc/bus/input is missing
          in input_boot_events
        - input.agent: use input_match_bits for bits parameters
        - default.hotplug: provides open file descriptors for stdin, stdout
          and stderr

Sun Mar 14 2004 ukai
        - ieee1394.agent: fix misplaced conversion code for module map
                        parameters
        - pci.rc: fix [: missing ']'

Thu Mar 11 2004 kroah
        - 2004_03_11 release
        - From Dmitry Torokhov <dtor_core@ameritech.net>:
                add evbug to the blacklist of modules
        - From Kay Sievers <kay.sievers@vrfy.org>:
                We should mention the DEVPATH in the hotplug man page too,
                as someone missed it and got confused.
        - 5 patches from Marco d'Itri <md@Linux.IT>:
                - 000_small_fixes: fixed some small bugs.
                - 001_no_bashisms: removed bashisms from all scripts.
                - 003_no_useless_includes: removed some unused code.
                - 004_2.6_pci_synthesis: added sysfs support to pci.rc,
                  enabling boot time events synthesis on lacking the
                  pcimodules program.
                - 004_2.6_usb_sysfs: improved sysfs support in the USB
                  scripts. Please review the changes marked with the FIXME
                  comment: this works on my system and others, but I'm not
                  sure that it's the proper way.

Fri Feb 13 2004 dbrownell
        - scsi.agent waits for /sys$DEVPATH/type to appear before
          modprobing higher level drivers.  Patch from Patrick
          Mansfield <patmans@us.ibm.com>

 


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Linux-usb-users@lists.sourceforge.net 
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-users


**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept
for the presence of computer viruses.

www.hubbell.com - Hubbell Incorporated
**********************************************************************

