Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267423AbUIUAjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267423AbUIUAjW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 20:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267421AbUIUAjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 20:39:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:51888 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267423AbUIUAjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 20:39:08 -0400
Date: Mon, 20 Sep 2004 17:38:27 -0700
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       Linux-usb-users@lists.sourceforge.net
Subject: [ANNOUNCE] 2004-04-20 release of hotplug scripts
Message-ID: <20040921003827.GA4098@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just packaged up the latest Linux hotplug scripts into a release,
which can be found at:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2004_09_20.tar.gz
or for those who like bz2 packages:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2004_09_20.tar.bz2
 
It contains a lot of little bug fixes, and the addition of the isapnp.rc
support.

The main web site for the linux-hotplug project can be found at:
	http://linux-hotplug.sf.net/
which contains lots of documentation on the whole linux-hotplug
process.
 
The release is still backwards compatible with 2.4, so there is no need
to worry about upgrading.

The full ChangeLog extract since the last release is included below for
those who want to know everything that's been changed, and who to blame
for them :)

thanks,

greg k-h

Mon Sep 20 2004 kroah
        - 2004_09_20 release
        - added README.modules to the makefile
        - added support for blacklists easier
          http://bugs.gentoo.org/show_bug.cgi?id=60214
        - ifrename is in /usr/sbin, not /sbin.
          http://bugs.gentoo.org/show_bug.cgi?id=46760
        - added isapnp support based on work from Simone Gotti
          <simone.gotti@email.it> and Marco d'Itri
        - fix minor debug message in net.agent for Gentoo boxes
        - allow *.usermap to have blank lines. (patch from Francesco Ferrara
          <ferrara@despammed.com>) at
          http://bugs.gentoo.org/show_bug.cgi?id=49748
        - add usbhid to the list of modules to unload on stop.
        - fix issue with input devices (joysticks specifically) not being
          loaded properly. (lots of gentoo bug ids...)
        - fixed minor issue with usbfs being mounted but no host drivers loaded
          yet <http://bugs.gentoo.org/show_bug.cgi?id=56599>
        - From Marcel Holtmann <marcel@holtmann.org>
                - fix location of FIRMWARE_DIR to /lib/firmware
        - From Bill Nottingham <notting@redhat.com>
                - support a a TwinMos mobile disk, as per https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=111506
        - Posix compliant changes From David Weinehall <tao@kernel.org>
                - changes tests using `-o' and `-a' to use || and && respectively.
                - changes bash-specific functions to generic sh-functions, adds
                  a missing newline at the end of a file, does a few `-o'
                  substitutions and changes /bin/bash to /bin/sh, since the
                  changes removes the need to use /bin/bash.
                - Modifies the remaining non-bash scripts to remove use of the
                  bash:ism local (a quick audit shows that it's not needed),
                  substitutes `-a' and `-o', changes fgrep to grep -F (this
                  change is not strictly necessary, but recommended by the
                  POSIX standard), and one occurence of egrep to grep (since
                  this particular occurence didn't make use of extended regexps
                  anyway)
                - Modifies the remaining bash scripts to use generic
                  sh-functions instead of bash-specific functions, does `-a'
                  and `-o' substitutions, removes use of local, and finally
                  changes /bin/bash to /bin/sh
        - From Alexander E. Patrakov
                - Remove bogus dependency upon "which" and "usbmodules"
                  programs in 2.6 code path
                - Add README.modules file
                - Provide the correct DEVICE variable for USB coldplug events
                  for 2.6.x kernels. The grep ...\$ is used instead of tail -c 4
                  because LFS has the tail command in /usr/bin. That's even
                  more illogical because head is in /bin.
                  This requires a 2.6.6 kernel. 2.6.4 is too old.
