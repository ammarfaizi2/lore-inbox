Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVCAVST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVCAVST (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 16:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVCAVST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 16:18:19 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:1637 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S262034AbVCAVSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 16:18:10 -0500
Date: Tue, 1 Mar 2005 16:18:09 -0500
From: Jeffrey Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/3] openfirmware/macio: implements hotplug for macio devices
Message-ID: <20050301211809.GA16465@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.111.19-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all -

I posted these patches a while ago, and let them fall by the wayside.

The following 3 patches, combined with the userspace patches referenced below,
implement hotplug events for open firmware/macio devices such as apple airport
wireless ethernet cards.

* 01-openfirmware-device-table.diff
  - Converts struct of_match to a MODULE_DEVICE_TABLE-compatible
    struct of_device_id
  - Uses the information to generate a device table parsable by
    depmod(8)

* 02-openfirmware-sysfs.diff
  - Exports openfirmware variables via sysfs so that coldplug can read and
    take appropriate action

* 03-openfirmware-hotplug.diff
  - Adds the hotplug routine for generating hotplug events. Uses the
    information published to provide the hotplug environment variables to
    userspace.

In addition to the kernel patches, userspace patches for hotplug and
module-init-tools are also required. These patches, including the kernel
patches, are available here:

ftp://ftp.suse.com/pub/people/jeffm/linux/macio-hotplug/

I'd appreciate any comments.

-Jeff

-- 
Jeff Mahoney
SuSE Labs
