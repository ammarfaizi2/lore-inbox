Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263184AbVG3XZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbVG3XZF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 19:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbVG3XZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 19:25:01 -0400
Received: from mail.dvmed.net ([216.237.124.58]:17623 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S263184AbVG3XYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 19:24:55 -0400
Message-ID: <42EC0C3E.7030705@pobox.com>
Date: Sat, 30 Jul 2005 19:24:46 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>
Subject: [git patches] new wireless stuffs
Content-Type: multipart/mixed;
 boundary="------------040606050705040408010709"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040606050705040408010709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


If this is post-2.6.13 material, that's fine.

I've been getting tired of the slow movement of wireless.  A little bit 
of that is my fault, certainly.  I've also been wanting to get these net 
drivers out to Linux users.

This adds HostAP, ipw2100, ipw2200, and the generic ieee80211 code.  The 
only -changes- in this set are cosmetic.

Further work is pending from SuSE and Intel [*poke* *poke* to them], but 
these should be working, and have been in -mm for quite a while.

One big thing I'm still hoping for is that someone will merge HostAP 
(where ieee80211 code came from) with the ieee80211 generic code.  The 
HostAP maintainer has been unwilling to do it, even though he has been 
good about keeping HostAP updated, so hopefully a volunteer will step up.

Please pull from branch 'ieee80211-wifi' of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to obtain the changes described by the attached diffstat/changelog.  The 
file additions were too large to attach, so I only attached the changes 
to existing files.  Existing drivers merely had some struct renames (for 
new ieee80211 header), and some 'add "static" attribute' changes.

	Jeff





--------------040606050705040408010709
Content-Type: text/plain;
 name="netdev-2.6.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netdev-2.6.txt"

 drivers/net/wireless/ieee802_11.h               |   78 
 Documentation/networking/README.ipw2100         |  246 
 Documentation/networking/README.ipw2200         |  290 
 MAINTAINERS                                     |    7 
 drivers/net/wireless/Kconfig                    |  106 
 drivers/net/wireless/Makefile                   |    6 
 drivers/net/wireless/airo.c                     |   65 
 drivers/net/wireless/atmel.c                    |   62 
 drivers/net/wireless/hostap/Kconfig             |  104 
 drivers/net/wireless/hostap/Makefile            |    8 
 drivers/net/wireless/hostap/hostap.c            | 1205 +++
 drivers/net/wireless/hostap/hostap.h            |   57 
 drivers/net/wireless/hostap/hostap_80211.h      |  107 
 drivers/net/wireless/hostap/hostap_80211_rx.c   | 1084 +++
 drivers/net/wireless/hostap/hostap_80211_tx.c   |  522 +
 drivers/net/wireless/hostap/hostap_ap.c         | 3286 +++++++++
 drivers/net/wireless/hostap/hostap_ap.h         |  272 
 drivers/net/wireless/hostap/hostap_common.h     |  558 +
 drivers/net/wireless/hostap/hostap_config.h     |   86 
 drivers/net/wireless/hostap/hostap_crypt.c      |  167 
 drivers/net/wireless/hostap/hostap_crypt.h      |   50 
 drivers/net/wireless/hostap/hostap_crypt_ccmp.c |  487 +
 drivers/net/wireless/hostap/hostap_crypt_tkip.c |  697 +
 drivers/net/wireless/hostap/hostap_crypt_wep.c  |  283 
 drivers/net/wireless/hostap/hostap_cs.c         |  985 ++
 drivers/net/wireless/hostap/hostap_download.c   |  766 ++
 drivers/net/wireless/hostap/hostap_hw.c         | 3634 ++++++++++
 drivers/net/wireless/hostap/hostap_info.c       |  499 +
 drivers/net/wireless/hostap/hostap_ioctl.c      | 4123 +++++++++++
 drivers/net/wireless/hostap/hostap_pci.c        |  455 +
 drivers/net/wireless/hostap/hostap_plx.c        |  622 +
 drivers/net/wireless/hostap/hostap_proc.c       |  448 +
 drivers/net/wireless/hostap/hostap_wlan.h       | 1074 ++
 drivers/net/wireless/ipw2100.c                  | 8641 ++++++++++++++++++++++++
 drivers/net/wireless/ipw2100.h                  | 1195 +++
 drivers/net/wireless/ipw2200.c                  | 7361 ++++++++++++++++++++
 drivers/net/wireless/ipw2200.h                  | 1770 ++++
 drivers/net/wireless/orinoco.c                  |   11 
 drivers/net/wireless/strip.c                    |    2 
 drivers/net/wireless/wavelan_cs.c               |   26 
 drivers/net/wireless/wavelan_cs.h               |    6 
 drivers/net/wireless/wavelan_cs.p.h             |   17 
 drivers/net/wireless/wl3501.h                   |    4 
 drivers/net/wireless/wl3501_cs.c                |   11 
 drivers/usb/net/Makefile                        |    2 
 drivers/usb/net/zd1201.c                        |   16 
 include/linux/etherdevice.h                     |    6 
 include/net/ieee80211.h                         |    4 
 include/net/ieee80211_crypt.h                   |   86 
 net/Kconfig                                     |    1 
 net/Makefile                                    |    1 
 net/ieee80211/Kconfig                           |   69 
 net/ieee80211/Makefile                          |   11 
 net/ieee80211/ieee80211_crypt.c                 |  259 
 net/ieee80211/ieee80211_crypt_ccmp.c            |  470 +
 net/ieee80211/ieee80211_crypt_tkip.c            |  708 +
 net/ieee80211/ieee80211_crypt_wep.c             |  272 
 net/ieee80211/ieee80211_module.c                |  273 
 net/ieee80211/ieee80211_rx.c                    | 1205 +++
 net/ieee80211/ieee80211_tx.c                    |  447 +
 net/ieee80211/ieee80211_wx.c                    |  471 +
 61 files changed, 45586 insertions(+), 198 deletions(-)



commit f3b10e1636dec053f4874d593e3de5d46da48a5f
Author: Jouni Malinen <jkmaline@cc.hut.fi>
Date:   Sat Jul 30 12:50:06 2005 -0700

    [PATCH] hostap update
    
    Fixed beacon frame when moving from monitor mode to master mode
    (workaround for firmware bug that left IBSS IE in the Beacon
    frames). This is using the same workaround that was previously used
    when moving from adhoc mode to master mode.
    
    Signed-off-by: Jouni Malinen <jkmaline@cc.hut.fi>
    Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

commit b15eff2632be3fcea68e01ba7f12e26a731e3157
Author: Pavel Roskin <proski@gnu.org>
Date:   Sat Jul 30 12:50:05 2005 -0700

    [PATCH] hostap update
    
    Warning fix for 64-bit platforms
    
    Hello!
    
    The patch fixes following warning seen on 64-bit platforms (in my case -
    x86_64, gcc-4.0):
    
    In file included from /usr/local/src/hostap/driver/modules/hostap_cs.c:203:
    /usr/local/src/hostap/driver/modules/hostap_hw.c: In function ?prism2_transmit_cb?:
    /usr/local/src/hostap/driver/modules/hostap_hw.c:1674: warning: cast from pointer to integer of different size
    /usr/local/src/hostap/driver/modules/hostap_hw.c: In function ?prism2_transmit?:
    /usr/local/src/hostap/driver/modules/hostap_hw.c:1758: warning: cast to pointer from integer of different size
    
    prism2_transmit_cb uses a (void *) argument to get an integer.   A
    simple fix would be to use double cast from pointer to long and then to
    int (and vice versa when int is passed as a pointer).  But I prefer a
    slightly longer patch.
    
    I believe that whenever an argument can hold both a pointer and an
    integer, it should be declared long.  long can hold both pointers and
    integers (except win64, but we are not coding for Windows), it can be
    cast to both of them and it's never assumed to be a valid pointer, which
    could be useful for some automatic code checkers.
    
    Signed-off-by: Pavel Roskin <proski@gnu.org>
    Signed-off-by: Jouni Malinen <jkmaline@cc.hut.fi>
    Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

commit 3e1d393240880e3d7ae580c46f1ba265643fcd15
Author: Brandon Enochs <enochs@itd.nrl.navy.mil>
Date:   Sat Jul 30 12:50:04 2005 -0700

    [PATCH] hostap update
    
    line 129 of hostap_80211_rx.c should read:
    
           LWNG_SETVAL(mactime, 2, 0, 4, rx_stats->mac_time);
    
    not:
           LWNG_SETVAL(mactime, 2, 0, 0, rx_stats->mac_time);
    
    The length field is incorrect.
    
    Signed-off-by: Jouni Malinen <jkmaline@cc.hut.fi>
    Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

commit 0c629a69fd8ec7b67566cfc052a9b1c4b927805a
Author: Jouni Malinen <jkmaline@cc.hut.fi>
Date:   Sat Jul 30 12:50:03 2005 -0700

    [PATCH] hostap update
    
    Firmware seems to be getting into odd state in host_roaming mode 2
    when hostscan is used without join command, so try to fix this by
    re-joining the current AP. This does not actually trigger a new
    association if the current AP is still in the scan results.
    
    This makes background scans (iwlist wlan0 scan) not to break data
    connection when in host_roaming 2 mode, e.g., when using wpa_supplicant.
    
    Signed-off-by: Jouni Malinen <jkmaline@cc.hut.fi>
    Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

commit 2e4fd068e7e25e654a454ed4a425f239c0f6407a
Author: Jouni Malinen <jkmaline@cc.hut.fi>
Date:   Sat Jul 30 12:50:02 2005 -0700

    [PATCH] hostap update
    
    Cleaned up scan result processing by converting struct
    hfa384x_scan_result into struct hfa384x_hostscan_result. This removes
    special cases from result processing since the results are only used
    in one, hostscan, format.
    
    Signed-off-by: Jouni Malinen <jkmaline@cc.hut.fi>
    Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

commit 72ca9c61cddb82a8596cee8141656d50aba42be5
Author: Jouni Malinen <jkmaline@cc.hut.fi>
Date:   Sat Jul 30 12:50:01 2005 -0700

    [PATCH] hostap update
    
    Added support for setting channel mask for scan requests
    ('iwpriv wlan0 scan_channels 0x00ff' masks scans to use channels 1-8).
    
    Signed-off-by: Jouni Malinen <jkmaline@cc.hut.fi>
    Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

commit f06ac319c05c6822f878f201ae80e54fbbe8be8c
Author: Jouni Malinen <jkmaline@cc.hut.fi>
Date:   Sat Jul 30 12:50:00 2005 -0700

    [PATCH] hostap update
    
    Add MODULE_VERSION information for the Host AP kernel modules and
    update the version string to indicate which version of the external
    Host AP driver is included in the kernel tree.
    
    Signed-off-by: Jouni Malinen <jkmaline@cc.hut.fi>
    Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

commit 093853c395df33104ee12c3df4398820d665d107
Author: Henrik Brix Andersen <brix@gentoo.org>
Date:   Sat Jul 30 12:49:59 2005 -0700

    [PATCH] hostap update
    
    pcmcia id_table for hostap_cs.c
    
    Hi Jouni,
    
    Here's a patch for adding a pcmcia id_table to hostap_cs.c as introduced
    by the PCMCIA subsystem changes in linux-2.6.13-rc1. The id_table allows
    hotplug (along with pcmciautils [1]) to load the driver without the need
    for the pcmcia-cs cardmgr daemon.
    
    The id_table was generated from the CVS version of hostap_cs.conf using
    a script borrowed from Dominik Brodowski. I have removed any duplicate
    entries, but I have only been able to test the functionality of the
    patch with a Linksys WPC11v3.
    
    Sincerely,
    Brix
    
    [1]: http://www.kernel.org/pub/linux/utils/kernel/pcmcia/
    
    Signed-off-by: Jouni Malinen <jkmaline@cc.hut.fi>
    Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

commit 0cd545d6ba0e0138782eb0ec287d0eb3db529b69
Author: Dave Hansen <haveblue@us.ibm.com>
Date:   Sat Jul 30 12:49:58 2005 -0700

    [PATCH] hostap update
    
    Create sysfs "device" files for hostap
    
    I was writing some scripts to automatically build kismet source lines,
    and I noticed that hostap devices don't have device files, unlike my
    prism54 and ipw2200 cards:
    
    $ ls -l /sys/class/net/eth0/device
    /sys/class/net/eth0/device -> ../../../devices/pci0000:00/0000:00:1e.0/0000:02:01.0
    $ ls -l /sys/class/net/wifi0
    ls: /sys/class/net/wifi0/device: No such file or directory
    $ ls -l /sys/class/net/wlan0
    ls: /sys/class/net/wlan0/device: No such file or directory
    
    The following (quite small) patch makes sure that both the wlan and wifi
    net devices have that pointer to the bus device.
    
    This way, I can do things like
    
            for i in /sys/class/net/*; do
                    if ! [ -e $i/device/drive ]; then
                            continue;
                    fi;
                    driver=$(basename $(readlink $i/device/driver))
                    case $driver in
                            hostap*)
                                    echo -- hostap,$i,$i-$driver
                                    break;
                            ipw2?00)
                                    echo -- $driver,$i,$i-$driver
                                    break;
                            prism54)
                                    echo prism54g,$i
                    esac
            done
    
    Which should generate a working set of source lines for kismet no matter
    what order I plug the cards in.
    
    It might also be handy to have a link between the two net devices, but
    that's a patch for another day.
    
    That patch is against 2.6.13-rc1-mm1.
    
    -- Dave
    
    Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
    Signed-off-by: Jouni Malinen <jkmaline@cc.hut.fi>
    Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

commit 0ef79ee22cf5c1b177184c18b6525889bcc6681f
Author: Jar <jar@pcuf.fi>
Date:   Sat Jul 30 12:49:57 2005 -0700

    [PATCH] hostap update
    
    hostap_cs: Remove irq_list, irq_mask and pcmcia/version.h
    
    Remove irq_list, irq_mask and pcmcia/version.h as suggested in
    http://kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html
    
    Signed-off-by: Jouni Malinen <jkmaline@cc.hut.fi>
    Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

commit 1fad810473423bbf0626fab2fbeb27a4663fa2d5
Author: Adrian Bunk <bunk@stusta.de>
Date:   Sat Jul 30 12:49:56 2005 -0700

    [PATCH] hostap update
    
    EXPORT_SYMTAB does nothing. There's no need to define something if it
    doesn't have any effect.
    
    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Jouni Malinen <jkmaline@cc.hut.fi>
    Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

commit 47e362cf6942de8b3a227929bf8bab578d92ad49
Author: Jouni Malinen <jkmaline@cc.hut.fi>
Date:   Sat Jul 30 12:49:55 2005 -0700

    [PATCH] hostap update
    
    Update hostap_cs to use new PCMCIA event callback registration.
    
    Signed-off-by: Jouni Malinen <jkmaline@cc.hut.fi>
    Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

commit de745fb27983770ebfdeaa70f8a36f791fb33786
Merge: 08cd84c81f27d5bd22ba958b7cae6d566c509280 a670fcb43f01a67ef56176afc76e5d43d128b25c
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Sat Jul 30 18:14:50 2005 -0400

    /spare/repo/netdev-2.6 branch 'ieee80211'

commit a670fcb43f01a67ef56176afc76e5d43d128b25c
Merge: 327309e899662b482c58cf25f574513d38b5788c b0825488a642cadcf39709961dde61440cb0731c
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Sat Jul 30 18:14:15 2005 -0400

    /spare/repo/netdev-2.6 branch 'master'

commit 08cd84c81f27d5bd22ba958b7cae6d566c509280
Merge: e9dd2561793c05d70c9df1bc16a2dde6f23388df 327309e899662b482c58cf25f574513d38b5788c
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Wed Jul 13 19:11:44 2005 -0400

    Merge /spare/repo/netdev-2.6 branch 'ieee80211'

commit 327309e899662b482c58cf25f574513d38b5788c
Merge: 0c168775709faa74c1b87f1e61046e0c51ade7f3 c32511e2718618f0b53479eb36e07439aa363a74
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Wed Jul 13 16:23:51 2005 -0400

    Merge upstream 2.6.13-rc3 into ieee80211 branch of netdev-2.6.

commit e9dd2561793c05d70c9df1bc16a2dde6f23388df
Merge: d011e151bc5d1a581bf35b492a4fde44d30382b9 0c168775709faa74c1b87f1e61046e0c51ade7f3
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Thu Jun 30 00:49:38 2005 -0400

    Merge /spare/repo/netdev-2.6 branch 'ieee80211'

commit 0c168775709faa74c1b87f1e61046e0c51ade7f3
Merge: 9bd481f85940726bf66aae5cd03c5b912ad0ae4c 9b4311eedb17fa88f02e4876cd6aa9a08e383cd6
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Thu Jun 30 00:49:18 2005 -0400

    Merge upstream 2.6.13-rc1-git1 into 'ieee80211' branch of netdev-2.6.

commit 9bd481f85940726bf66aae5cd03c5b912ad0ae4c
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Tue Jun 28 01:46:35 2005 -0400

    wireless: fix ipw warning; add is_broadcast_ether_addr() to linux/etherdevice.h

commit d011e151bc5d1a581bf35b492a4fde44d30382b9
Merge: 30b4d6565e4d57c6d03600c7822411c7cac19638 2179a59db18ddf8eb3fd0133a3bee57f1c2b5b06
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Tue Jun 28 00:46:58 2005 -0400

    Merge /spare/repo/netdev-2.6 branch 'ieee80211'

commit 2179a59db18ddf8eb3fd0133a3bee57f1c2b5b06
Merge: ad3fee560bc508008b3b2cf6358105c4c7081921 99f95e5286df2f69edab8a04c7080d986ee4233b
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Tue Jun 28 00:46:46 2005 -0400

    Merge /spare/repo/linux-2.6/

commit 30b4d6565e4d57c6d03600c7822411c7cac19638
Merge: aa8f6dfd355021b4dd8b74b0588fd6fd8f21b79f ad3fee560bc508008b3b2cf6358105c4c7081921
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Mon Jun 27 23:45:25 2005 -0400

    Merge /spare/repo/netdev-2.6 branch 'ieee80211'

commit ad3fee560bc508008b3b2cf6358105c4c7081921
Author: Andrew Morton <akpm@osdl.org>
Date:   Mon Jun 20 14:30:36 2005 -0700

    [PATCH] wireless-device-attr-fixes-2
    
    More fixes for greg depredations.
    
    Also nuke lots of pointless typecasts.
    
    All this new wireless code adds near-infinite amounts of trailing whitespace.
    
    Cc: Jeff Garzik <jgarzik@pobox.com>
    Cc: Greg KH <greg@kroah.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

commit edfc43f2ec542c17c479d8ec7e4b0cee7b20f578
Author: Andrew Morton <akpm@osdl.org>
Date:   Mon Jun 20 14:30:35 2005 -0700

    [PATCH] wireless-device-attr-fixes
    
    Repair Jeff's stuff after gregkh depredations.
    
    Cc: Jeff Garzik <jgarzik@pobox.com>
    Cc: Greg KH <greg@kroah.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

commit 011fe95a3b25ff124486fc27dc0395904ecf5852
Author: Andrew Morton <akpm@osdl.org>
Date:   Mon Jun 20 14:30:36 2005 -0700

    [PATCH] ipw2100 old gcc fix
    
    drivers/net/wireless/ipw2100.c: In function `ipw2100_set_key_index':
    drivers/net/wireless/ipw2100.c:5326: array index in non-array initializer
    drivers/net/wireless/ipw2100.c:5326: (near initialization for `cmd')
    drivers/net/wireless/ipw2100.c:5326: warning: missing braces around initializer
    drivers/net/wireless/ipw2100.c:5326: warning: (near initialization for `cmd.host_command_parameters')
    
    Cc: Jeff Garzik <jgarzik@pobox.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

commit 8724a118031a4eb62174b3e12745e4d35d4b03fe
Author: Pavel Machek <pavel@ucw.cz>
Date:   Mon Jun 20 14:28:43 2005 -0700

    [PATCH] ipw2100: small cleanups
    
    Fix few typos/thinkos in ipw, remove ugly macro (it is commented around,
    anyway), and fix types passed to pci_set_power_state.
    
    Signed-off-by: Andrew Morton <akpm@osdl.org>

commit 5dc54a65b6981d327a84c7651bbfeef0c0aff977
Author: Pavel Machek <pavel@ucw.cz>
Date:   Mon Jun 20 14:28:43 2005 -0700

    [PATCH] ipw2100: kill dead macros
    
    There are several never used macros in ipw2100.  This removes them.
    
    Signed-off-by: Pavel Machek <pavel@suse.cz>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

commit 4663663f1d91aa0b84526841e47f401598bfa2f4
Author: Pavel Machek <pavel@ucw.cz>
Date:   Mon Jun 20 14:28:42 2005 -0700

    [PATCH] ipw2100: assume recent kernel
    
    ipw2100 still has support for old kernels.  Thats considered bad for patch in
    mainline...  this fixes few instances.
    
    Signed-off-by: Pavel Machek <pavel@suse.cz>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

commit 0e08b44eedacb7824c88678d9a9ea7db25b5401c
Author: Tobias Klauser <tklauser@nuerscht.ch>
Date:   Mon Jun 20 14:28:41 2005 -0700

    [PATCH] drivers/net/wireless/ipw2200: Use the DMA_32BIT_MASK constant
    
    Use the DMA_32BIT_MASK constant from dma-mapping.h when calling
    pci_set_dma_mask() or pci_set_consistent_dma_mask() instead of custom macros.
    
    This patch includes dma-mapping.h explicitly because it caused errors on some
    architectures otherwise.  See
    http://marc.theaimsgroup.com/?t=108001993000001&r=1&w=2 for details
    
    Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
    Cc: Jeff Garzik <jgarzik@pobox.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

commit 05743d165be9f0293b4ff67f4e1cf3724eb13e1f
Author: Tobias Klauser <tklauser@nuerscht.ch>
Date:   Mon Jun 20 14:28:40 2005 -0700

    [PATCH] drivers/net/wireless/ipw2100: Use the DMA_32BIT_MASK constant
    
    Use the DMA_32BIT_MASK constant from dma-mapping.h when calling
    pci_set_dma_mask() or pci_set_consistent_dma_mask() instead of custom macros.
    
    This patch includes dma-mapping.h explicitly because it caused errors on some
    architectures otherwise.  See
    http://marc.theaimsgroup.com/?t=108001993000001&r=1&w=2 for details
    
    Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
    Cc: Jeff Garzik <jgarzik@pobox.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

commit 070d01651296d3c87bca94f3b1313447e9e06c2f
Author: Pavel Machek <pavel@ucw.cz>
Date:   Mon Jun 20 13:33:07 2005 +0200

    [PATCH] ipw2100: remove commented-out code
    
    This removes up various code/defines that was just commented out
    instead of being deleted.

commit aaa4d308a8cbc4ccfd870ee556def2e481557274
Author: Jiri Benc <jbenc@suse.cz>
Date:   Tue Jun 7 14:58:41 2005 +0200

    [PATCH] ieee80211: fix ipw 64bit compilation warnings
    
    On Mon, 06 Jun 2005 14:29:52 +0800, Zhu Yi wrote:
    > ("%zd", sizeof()) should be better.
    
    Thanks. This is a corrected version of the patch.
    
    This patch fixes warnings when compiling ipw2100 and ipw2200 on x86_64.
    
    Signed-off-by: Jiri Benc <jbenc@suse.cz>
    Signed-off-by: Jirka Bohac <jbohac@suse.cz>

commit e19b813e0c9c5995423dc95b01379c89f188ae70
Author: Adrian Bunk <bunk@stusta.de>
Date:   Fri Jun 3 18:29:20 2005 +0200

    [PATCH] ieee80211: fix recursive ipw2200 dependencies
    
    This results in recursive dependencies:
    - IPW2200 depends on NET_RADIO
    - IPW2200 selects IEEE80211
    - IEEE80211 selects NET_RADIO
    
    This patch fixes the IPW2200 dependencies in a way that they are similar
    to the IPW2100 dependencies.
    
    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Jiri Benc <jbenc@suse.cz>

commit 7c9d4c70b20e165eb11d8aed2b6374377d17f43a
Author: Adrian Bunk <bunk@stusta.de>
Date:   Fri Jun 3 18:28:19 2005 +0200

    [PATCH] ieee80211: remove pci.h #include's
    
    I was wondering why editing pci.h triggered the rebuild of three files
    under net/, and as far as I can see, there's no reason for these three
    files to #include pci.h .
    
    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Jiri Benc <jbenc@suse.cz>

commit aa8f6dfd355021b4dd8b74b0588fd6fd8f21b79f
Merge: f45727d52d1581e9ff4df9d1a12a60789ad2d1eb 245ac8738b0b840552d56b842e70e750d65911cc
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Mon Jun 27 22:50:10 2005 -0400

    Merge /spare/repo/netdev-2.6 branch 'ieee80211'

commit 245ac8738b0b840552d56b842e70e750d65911cc
Merge: 716b43303df605510399d6da0d0dd4e2ea376e7c a5fe736eaf9bae1b45317313de04b564441b94f2
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Mon Jun 27 22:49:47 2005 -0400

    Merge upstream net/ieee80211.h changes into 'ieee80211' branch.

commit 716b43303df605510399d6da0d0dd4e2ea376e7c
Merge: 5696c1944a33b4434a9a1ebb6383b906afd43a10 c7b645f934e52a54af58142d91fb51f881f8ce26
Author: Jeff Garzik <jgarzik@pretzel.yyz.us>
Date:   Mon Jun 27 22:03:52 2005 -0400

    Merge upstream ieee80211.h with us (us == branch 'ieee80211' of netdev-2.6)

commit f45727d52d1581e9ff4df9d1a12a60789ad2d1eb
Merge: 4c925f452cfd16c690209e96821ee094e09a2404 5696c1944a33b4434a9a1ebb6383b906afd43a10
Author: Jeff Garzik <jgarzik@pretzel.yyz.us>
Date:   Sun Jun 26 23:42:30 2005 -0400

    Merge /spare/repo/netdev-2.6/ branch 'ieee80211'

commit 5696c1944a33b4434a9a1ebb6383b906afd43a10
Merge: 66b04a80eea60cabf9d89fd34deb3234a740052f 020f46a39eb7b99a575b9f4d105fce2b142acdf1
Author: Jeff Garzik <jgarzik@pretzel.yyz.us>
Date:   Sun Jun 26 23:38:58 2005 -0400

    Merge /spare/repo/linux-2.6/

commit 4c925f452cfd16c690209e96821ee094e09a2404
Merge: 51a730d758ae4052e10ca7e06336f10af598c4fc 66b04a80eea60cabf9d89fd34deb3234a740052f
Author:  <jgarzik@pretzel.yyz.us>
Date:   Fri May 27 22:57:33 2005 -0400

    Automatic merge of /spare/repo/netdev-2.6 branch we18-ieee80211

commit 66b04a80eea60cabf9d89fd34deb3234a740052f
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Fri May 27 22:53:55 2005 -0400

    [wireless] ipw2100: fix build after applying SuSE cleanups
    
    s/ieee80211_header_data/ieee80211_hdr_3addr/

commit 286d974797705ae7ceedc846666ef98bdeee3646
Author: Jiri Benc <jbenc@suse.cz>
Date:   Tue May 24 15:10:18 2005 +0200

    [PATCH] ieee80211: cleanup
    
    Cleanup of unused and duplicated constants and structures in the ieee80211
    header.
    
    Signed-off-by: Jiri Benc <jbenc@suse.cz>
    Signed-off-by: Jirka Bohac <jbohac@suse.cz>

commit 76fe1b0e4c093f985c66a062c9c10370b4985796
Author: Adrian Bunk <bunk@stusta.de>
Date:   Sat May 7 00:54:49 2005 +0200

    [PATCH] fix IEEE80211_CRYPT_* selects
    
    Some of the options didn't obey the most important rule of select
    
      If you select something, you have to ensure that the dependencies
      of what you do select are fulfilled.
    
    resulting in the following compile error:
    
    <--  snip  -->
    
    ...
      LD      .tmp_vmlinux1
    crypto/built-in.o(.init.text+0x31b): In function `aes_init':
    : undefined reference to `crypto_register_alg'
    crypto/built-in.o(.init.text+0x326): In function `michael_mic_init':
    : undefined reference to `crypto_register_alg'
    crypto/built-in.o(.exit.text+0x6): In function `aes_fini':
    : undefined reference to `crypto_unregister_alg'
    crypto/built-in.o(.exit.text+0x16): In function `michael_mic_exit':
    : undefined reference to `crypto_unregister_alg'
    net/built-in.o(.text+0x5ba52): In function `ieee80211_ccmp_init':
    : undefined reference to `crypto_alloc_tfm'
    net/built-in.o(.text+0x5ba94): In function `ieee80211_ccmp_init':
    : undefined reference to `crypto_free_tfm'
    net/built-in.o(.text+0x5bab7): In function `ieee80211_ccmp_deinit':
    : undefined reference to `crypto_free_tfm'
    net/built-in.o(.text+0x5c5c2): In function `ieee80211_tkip_init':
    : undefined reference to `crypto_alloc_tfm'
    net/built-in.o(.text+0x5c5d5): In function `ieee80211_tkip_init':
    : undefined reference to `crypto_alloc_tfm'
    net/built-in.o(.text+0x5c623): In function `ieee80211_tkip_init':
    : undefined reference to `crypto_free_tfm'
    net/built-in.o(.text+0x5c62a): In function `ieee80211_tkip_init':
    : undefined reference to `crypto_free_tfm'
    net/built-in.o(.text+0x5c65e): In function `ieee80211_tkip_deinit':
    : undefined reference to `crypto_free_tfm'
    net/built-in.o(.text+0x5c665): In function `ieee80211_tkip_deinit':
    : undefined reference to `crypto_free_tfm'
    make: *** [.tmp_vmlinux1] Error 1
    
    <--  snip  -->
    
    This patch adds the missing selects of CRYPTO (similar to how
    IEEE80211_CRYPT_WEP already does it).
    
    Yes, you could argue whether CRYPTO should be select'ed by the CRYPTO_*
    options, but with the current CRYPTO* dependencies this patch is
    required.

commit e157249d948bf0c5da10ce8610e2b4b36d0a3c4c
Author: Adrian Bunk <bunk@stusta.de>
Date:   Fri May 6 23:32:39 2005 +0200

    [PATCH] net/ieee80211/: make two functions static
    
    This patch makes two needlessly global functions static.
    
    Signed-off-by: Adrian Bunk <bunk@stusta.de>

commit 3dcefbc9d6bd8b5ff0fc4bdbe3df938be5460f79
Author: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Date:   Tue Apr 26 18:43:05 2005 +0100

    [PATCH] zd1201 fixes
    
    	In netdev-2.6 we need to update zd1201.c since we don't have
    driver/net/wireless/ieee802_11.h anymore.
    
    Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>

commit 695b5bc3ecfc7da0a29360a6c2ee0849ffdb300a
Author: Al Viro <viro@www.linux.org.uk>
Date:   Sun Apr 3 09:15:52 2005 +0100

    [PATCH] ieee80211_module.c::store_debug_level() cleanup
    
    	* trivial __user annotations
    	* store_debug_level() sanitized a bit
    Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>

commit 51a730d758ae4052e10ca7e06336f10af598c4fc
Merge: 6cd15a9daf826115356f9403494c76e5aafa7793 ff0e0ea2f5d36fa90fc2c57fd019102b0a0cfabf
Author:  <jgarzik@pretzel.yyz.us>
Date:   Fri May 27 22:08:07 2005 -0400

    Automatic merge of /spare/repo/netdev-2.6 branch we18-ieee80211

commit ff0e0ea2f5d36fa90fc2c57fd019102b0a0cfabf
Merge: 43f66a6ce8da299344cf1bc2ac2311889cc88555 1f15d694522af9cd7492695f11dd2dc77b6cf098
Author:  <jgarzik@pretzel.yyz.us>
Date:   Fri May 27 22:07:40 2005 -0400

    Automatic merge of /spare/repo/netdev-2.6 branch we18

commit 6cd15a9daf826115356f9403494c76e5aafa7793
Merge: ff1d2767d5a43c85f944e86a45284b721f66196c 43f66a6ce8da299344cf1bc2ac2311889cc88555
Author:  <jgarzik@pretzel.yyz.us>
Date:   Fri May 27 22:02:58 2005 -0400

    Automatic merge of /spare/repo/netdev-2.6 branch we18-ieee80211

commit 43f66a6ce8da299344cf1bc2ac2311889cc88555
Author: James Ketrenos <jketreno@linux.intel.com>
Date:   Fri Mar 25 12:31:53 2005 -0600

    Add ipw2200 wireless driver.

commit 2c86c275015c880e810830304a3a4ab94803b38b
Author: James Ketrenos <jketreno@linux.intel.com>
Date:   Wed Mar 23 17:32:29 2005 -0600

    Add ipw2100 wireless driver.

commit 0a989b24fd59e8867274246587b46f5595fa0baa
Author: Adrian Bunk <bunk@stusta.de>
Date:   Mon Apr 11 16:52:15 2005 -0700

    [PATCH] net/ieee80211/ieee80211_tx.c: swapped memset arguments
    
    Fix swapped memset() arguments in net/ieee80211/ieee80211_tx.c found by
    Maciej Soltysiak.
    
    Patch by Jesper Juhl.
    
    Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

commit ff1d2767d5a43c85f944e86a45284b721f66196c
Author: Jouni Malinen <jkmaline@cc.hut.fi>
Date:   Thu May 12 22:54:16 2005 -0400

    Add HostAP wireless driver.
    
    Includes minor cleanups from Adrian Bunk <bunk@stusta.de>.

commit b453872c35cfcbdbf5a794737817f7d4e7b1b579
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Thu May 12 22:48:20 2005 -0400

    [NET] ieee80211 subsystem
    
    Contributors:
    Host AP contributors
    James Ketrenos <jketreno@linux.intel.com>
    Francois Romieu <romieu@fr.zoreil.com>
    Adrian Bunk <bunk@stusta.de>
    Matthew Galgoci <mgalgoci@parcelfarce.linux.th
    eplanet.co.uk>



--------------040606050705040408010709
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -991,6 +991,13 @@ M:	mike.miller@hp.com
 L:	iss_storagedev@hp.com
 S:	Supported
  
+HOST AP DRIVER
+P:	Jouni Malinen
+M:	jkmaline@cc.hut.fi
+L:	hostap@shmoo.com
+W:	http://hostap.epitest.fi/
+S:	Maintained
+
 HP100:	Driver for HP 10/100 Mbit/s Voice Grade Network Adapter Series
 P:	Jaroslav Kysela
 M:	perex@suse.cz
diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -137,6 +137,110 @@ config PCMCIA_RAYCS
 comment "Wireless 802.11b ISA/PCI cards support"
 	depends on NET_RADIO && (ISA || PCI || PPC_PMAC || PCMCIA)
 
+config IPW2100
+	tristate "Intel PRO/Wireless 2100 Network Connection"
+	depends on NET_RADIO && PCI && IEEE80211
+	select FW_LOADER
+	---help---
+          A driver for the Intel PRO/Wireless 2100 Network 
+	  Connection 802.11b wireless network adapter.
+
+          See <file:Documentation/networking/README.ipw2100> for information on
+          the capabilities currently enabled in this driver and for tips
+          for debugging issues and problems.
+
+	  In order to use this driver, you will need a firmware image for it.
+          You can obtain the firmware from
+	  <http://ipw2100.sf.net/>.  Once you have the firmware image, you 
+	  will need to place it in /etc/firmware.
+
+          You will also very likely need the Wireless Tools in order to
+          configure your card:
+
+          <http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html>.
+ 
+          If you want to compile the driver as a module ( = code which can be
+          inserted in and remvoed from the running kernel whenever you want),
+          say M here and read <file:Documentation/modules.txt>.  The module
+          will be called ipw2100.ko.
+	
+config IPW2100_PROMISC
+        bool "Enable promiscuous mode"
+        depends on IPW2100
+        ---help---
+	  Enables promiscuous/monitor mode support for the ipw2100 driver.
+	  With this feature compiled into the driver, you can switch to 
+	  promiscuous mode via the Wireless Tool's Monitor mode.  While in this
+	  mode, no packets can be sent.
+
+config IPW_DEBUG
+	bool "Enable full debugging output in IPW2100 module."
+	depends on IPW2100
+	---help---
+	  This option will enable debug tracing output for the IPW2100.  
+
+	  This will result in the kernel module being ~60k larger.  You can 
+	  control which debug output is sent to the kernel log by setting the 
+	  value in 
+
+	  /sys/bus/pci/drivers/ipw2100/debug_level
+
+	  This entry will only exist if this option is enabled.
+
+	  If you are not trying to debug or develop the IPW2100 driver, you 
+	  most likely want to say N here.
+
+config IPW2200
+	tristate "Intel PRO/Wireless 2200BG and 2915ABG Network Connection"
+	depends on IEEE80211 && PCI
+	select FW_LOADER
+	---help---
+          A driver for the Intel PRO/Wireless 2200BG and 2915ABG Network
+	  Connection adapters. 
+
+          See <file:Documentation/networking/README.ipw2200> for 
+	  information on the capabilities currently enabled in this 
+	  driver and for tips for debugging issues and problems.
+
+	  In order to use this driver, you will need a firmware image for it.
+          You can obtain the firmware from
+	  <http://ipw2200.sf.net/>.  See the above referenced README.ipw2200 
+	  for information on where to install the firmare images.
+
+          You will also very likely need the Wireless Tools in order to
+          configure your card:
+
+          <http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html>.
+ 
+          If you want to compile the driver as a module ( = code which can be
+          inserted in and remvoed from the running kernel whenever you want),
+          say M here and read <file:Documentation/modules.txt>.  The module
+          will be called ipw2200.ko.
+
+config IPW_DEBUG
+	bool "Enable full debugging output in IPW2200 module."
+	depends on IPW2200
+	---help---
+	  This option will enable debug tracing output for the IPW2200.  
+
+	  This will result in the kernel module being ~100k larger.  You can 
+	  control which debug output is sent to the kernel log by setting the 
+	  value in 
+
+	  /sys/bus/pci/drivers/ipw2200/debug_level
+
+	  This entry will only exist if this option is enabled.
+
+	  To set a value, simply echo an 8-byte hex value to the same file:
+
+	  % echo 0x00000FFO > /sys/bus/pci/drivers/ipw2200/debug_level
+
+	  You can find the list of debug mask values in 
+	  drivers/net/wireless/ipw2200.h
+
+	  If you are not trying to debug or develop the IPW2200 driver, you 
+	  most likely want to say N here.
+
 config AIRO
 	tristate "Cisco/Aironet 34X/35X/4500/4800 ISA and PCI cards"
 	depends on NET_RADIO && ISA && (PCI || BROKEN)
@@ -355,6 +459,8 @@ config PRISM54
 	  say M here and read <file:Documentation/modules.txt>.  The module
 	  will be called prism54.ko.
 
+source "drivers/net/wireless/hostap/Kconfig"
+
 # yes, this works even when no drivers are selected
 config NET_WIRELESS
 	bool
diff --git a/drivers/net/wireless/Makefile b/drivers/net/wireless/Makefile
--- a/drivers/net/wireless/Makefile
+++ b/drivers/net/wireless/Makefile
@@ -2,6 +2,10 @@
 # Makefile for the Linux Wireless network device drivers.
 #
 
+obj-$(CONFIG_IPW2100) += ipw2100.o
+
+obj-$(CONFIG_IPW2200) += ipw2200.o
+
 obj-$(CONFIG_STRIP) += strip.o
 obj-$(CONFIG_ARLAN) += arlan.o 
 
@@ -28,6 +32,8 @@ obj-$(CONFIG_PCMCIA_ATMEL)      += atmel
 
 obj-$(CONFIG_PRISM54)		+= prism54/
 
+obj-$(CONFIG_HOSTAP)		+= hostap/
+
 # 16-bit wireless PCMCIA client drivers
 obj-$(CONFIG_PCMCIA_RAYCS)	+= ray_cs.o
 obj-$(CONFIG_PCMCIA_WL3501)	+= wl3501_cs.o
diff --git a/drivers/net/wireless/airo.c b/drivers/net/wireless/airo.c
--- a/drivers/net/wireless/airo.c
+++ b/drivers/net/wireless/airo.c
@@ -1040,7 +1040,7 @@ typedef struct {
 	u16 status;
 } WifiCtlHdr;
 
-WifiCtlHdr wifictlhdr8023 = {
+static WifiCtlHdr wifictlhdr8023 = {
 	.ctlhdr = {
 		.ctl	= HOST_DONT_RLSE,
 	}
@@ -1111,13 +1111,13 @@ static int airo_thread(void *data);
 static void timer_func( struct net_device *dev );
 static int airo_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 #ifdef WIRELESS_EXT
-struct iw_statistics *airo_get_wireless_stats (struct net_device *dev);
+static struct iw_statistics *airo_get_wireless_stats (struct net_device *dev);
 static void airo_read_wireless_stats (struct airo_info *local);
 #endif /* WIRELESS_EXT */
 #ifdef CISCO_EXT
 static int readrids(struct net_device *dev, aironet_ioctl *comp);
 static int writerids(struct net_device *dev, aironet_ioctl *comp);
-int flashcard(struct net_device *dev, aironet_ioctl *comp);
+static int flashcard(struct net_device *dev, aironet_ioctl *comp);
 #endif /* CISCO_EXT */
 #ifdef MICSUPPORT
 static void micinit(struct airo_info *ai);
@@ -1226,6 +1226,12 @@ static int setup_proc_entry( struct net_
 static int takedown_proc_entry( struct net_device *dev,
 				struct airo_info *apriv );
 
+static int cmdreset(struct airo_info *ai);
+static int setflashmode (struct airo_info *ai);
+static int flashgchar(struct airo_info *ai,int matchbyte,int dwelltime);
+static int flashputbuf(struct airo_info *ai);
+static int flashrestart(struct airo_info *ai,struct net_device *dev);
+
 #ifdef MICSUPPORT
 /***********************************************************************
  *                              MIC ROUTINES                           *
@@ -1234,10 +1240,11 @@ static int takedown_proc_entry( struct n
 
 static int RxSeqValid (struct airo_info *ai,miccntx *context,int mcast,u32 micSeq);
 static void MoveWindow(miccntx *context, u32 micSeq);
-void emmh32_setseed(emmh32_context *context, u8 *pkey, int keylen, struct crypto_tfm *);
-void emmh32_init(emmh32_context *context);
-void emmh32_update(emmh32_context *context, u8 *pOctets, int len);
-void emmh32_final(emmh32_context *context, u8 digest[4]);
+static void emmh32_setseed(emmh32_context *context, u8 *pkey, int keylen, struct crypto_tfm *);
+static void emmh32_init(emmh32_context *context);
+static void emmh32_update(emmh32_context *context, u8 *pOctets, int len);
+static void emmh32_final(emmh32_context *context, u8 digest[4]);
+static int flashpchar(struct airo_info *ai,int byte,int dwelltime);
 
 /* micinit - Initialize mic seed */
 
@@ -1315,7 +1322,7 @@ static int micsetup(struct airo_info *ai
 	return SUCCESS;
 }
 
-char micsnap[]= {0xAA,0xAA,0x03,0x00,0x40,0x96,0x00,0x02};
+static char micsnap[] = {0xAA,0xAA,0x03,0x00,0x40,0x96,0x00,0x02};
 
 /*===========================================================================
  * Description: Mic a packet
@@ -1570,7 +1577,7 @@ static void MoveWindow(miccntx *context,
 static unsigned char aes_counter[16];
 
 /* expand the key to fill the MMH coefficient array */
-void emmh32_setseed(emmh32_context *context, u8 *pkey, int keylen, struct crypto_tfm *tfm)
+static void emmh32_setseed(emmh32_context *context, u8 *pkey, int keylen, struct crypto_tfm *tfm)
 {
   /* take the keying material, expand if necessary, truncate at 16-bytes */
   /* run through AES counter mode to generate context->coeff[] */
@@ -1602,7 +1609,7 @@ void emmh32_setseed(emmh32_context *cont
 }
 
 /* prepare for calculation of a new mic */
-void emmh32_init(emmh32_context *context)
+static void emmh32_init(emmh32_context *context)
 {
 	/* prepare for new mic calculation */
 	context->accum = 0;
@@ -1610,7 +1617,7 @@ void emmh32_init(emmh32_context *context
 }
 
 /* add some bytes to the mic calculation */
-void emmh32_update(emmh32_context *context, u8 *pOctets, int len)
+static void emmh32_update(emmh32_context *context, u8 *pOctets, int len)
 {
 	int	coeff_position, byte_position;
   
@@ -1652,7 +1659,7 @@ void emmh32_update(emmh32_context *conte
 static u32 mask32[4] = { 0x00000000L, 0xFF000000L, 0xFFFF0000L, 0xFFFFFF00L };
 
 /* calculate the mic */
-void emmh32_final(emmh32_context *context, u8 digest[4])
+static void emmh32_final(emmh32_context *context, u8 digest[4])
 {
 	int	coeff_position, byte_position;
 	u32	val;
@@ -2255,7 +2262,7 @@ static void airo_read_stats(struct airo_
 	ai->stats.rx_fifo_errors = vals[0];
 }
 
-struct net_device_stats *airo_get_stats(struct net_device *dev)
+static struct net_device_stats *airo_get_stats(struct net_device *dev)
 {
 	struct airo_info *local =  dev->priv;
 
@@ -2414,7 +2421,7 @@ EXPORT_SYMBOL(stop_airo_card);
 
 static int add_airo_dev( struct net_device *dev );
 
-int wll_header_parse(struct sk_buff *skb, unsigned char *haddr)
+static int wll_header_parse(struct sk_buff *skb, unsigned char *haddr)
 {
 	memcpy(haddr, skb->mac.raw + 10, ETH_ALEN);
 	return ETH_ALEN;
@@ -2681,7 +2688,7 @@ static struct net_device *init_wifidev(s
 	return dev;
 }
 
-int reset_card( struct net_device *dev , int lock) {
+static int reset_card( struct net_device *dev , int lock) {
 	struct airo_info *ai = dev->priv;
 
 	if (lock && down_interruptible(&ai->sem))
@@ -2696,9 +2703,9 @@ int reset_card( struct net_device *dev ,
 	return 0;
 }
 
-struct net_device *_init_airo_card( unsigned short irq, int port,
-				    int is_pcmcia, struct pci_dev *pci,
-				    struct device *dmdev )
+static struct net_device *_init_airo_card( unsigned short irq, int port,
+					   int is_pcmcia, struct pci_dev *pci,
+					   struct device *dmdev )
 {
 	struct net_device *dev;
 	struct airo_info *ai;
@@ -7235,7 +7242,7 @@ static void airo_read_wireless_stats(str
 	local->wstats.miss.beacon = vals[34];
 }
 
-struct iw_statistics *airo_get_wireless_stats(struct net_device *dev)
+static struct iw_statistics *airo_get_wireless_stats(struct net_device *dev)
 {
 	struct airo_info *local =  dev->priv;
 
@@ -7450,14 +7457,8 @@ static int writerids(struct net_device *
  * Flash command switch table
  */
 
-int flashcard(struct net_device *dev, aironet_ioctl *comp) {
+static int flashcard(struct net_device *dev, aironet_ioctl *comp) {
 	int z;
-	int cmdreset(struct airo_info *);
-	int setflashmode(struct airo_info *);
-	int flashgchar(struct airo_info *,int,int);
-	int flashpchar(struct airo_info *,int,int);
-	int flashputbuf(struct airo_info *);
-	int flashrestart(struct airo_info *,struct net_device *);
 
 	/* Only super-user can modify flash */
 	if (!capable(CAP_NET_ADMIN))
@@ -7515,7 +7516,7 @@ int flashcard(struct net_device *dev, ai
  * card.
  */
 
-int cmdreset(struct airo_info *ai) {
+static int cmdreset(struct airo_info *ai) {
 	disable_MAC(ai, 1);
 
 	if(!waitbusy (ai)){
@@ -7539,7 +7540,7 @@ int cmdreset(struct airo_info *ai) {
  * mode
  */
 
-int setflashmode (struct airo_info *ai) {
+static int setflashmode (struct airo_info *ai) {
 	set_bit (FLAG_FLASHING, &ai->flags);
 
 	OUT4500(ai, SWS0, FLASH_COMMAND);
@@ -7566,7 +7567,7 @@ int setflashmode (struct airo_info *ai) 
  * x 50us for  echo .
  */
 
-int flashpchar(struct airo_info *ai,int byte,int dwelltime) {
+static int flashpchar(struct airo_info *ai,int byte,int dwelltime) {
 	int echo;
 	int waittime;
 
@@ -7606,7 +7607,7 @@ int flashpchar(struct airo_info *ai,int 
  * Get a character from the card matching matchbyte
  * Step 3)
  */
-int flashgchar(struct airo_info *ai,int matchbyte,int dwelltime){
+static int flashgchar(struct airo_info *ai,int matchbyte,int dwelltime){
 	int           rchar;
 	unsigned char rbyte=0;
 
@@ -7637,7 +7638,7 @@ int flashgchar(struct airo_info *ai,int 
  * send to the card
  */
 
-int flashputbuf(struct airo_info *ai){
+static int flashputbuf(struct airo_info *ai){
 	int            nwords;
 
 	/* Write stuff */
@@ -7659,7 +7660,7 @@ int flashputbuf(struct airo_info *ai){
 /*
  *
  */
-int flashrestart(struct airo_info *ai,struct net_device *dev){
+static int flashrestart(struct airo_info *ai,struct net_device *dev){
 	int    i,status;
 
 	ssleep(1);			/* Added 12/7/00 */
diff --git a/drivers/net/wireless/atmel.c b/drivers/net/wireless/atmel.c
--- a/drivers/net/wireless/atmel.c
+++ b/drivers/net/wireless/atmel.c
@@ -68,7 +68,7 @@
 #include <linux/device.h>
 #include <linux/moduleparam.h>
 #include <linux/firmware.h>
-#include "ieee802_11.h"
+#include <net/ieee80211.h>
 #include "atmel.h"
 
 #define DRIVER_MAJOR 0
@@ -618,12 +618,12 @@ static int atmel_lock_mac(struct atmel_p
 static void atmel_wmem32(struct atmel_private *priv, u16 pos, u32 data);
 static void atmel_command_irq(struct atmel_private *priv);
 static int atmel_validate_channel(struct atmel_private *priv, int channel);
-static void atmel_management_frame(struct atmel_private *priv, struct ieee802_11_hdr *header, 
+static void atmel_management_frame(struct atmel_private *priv, struct ieee80211_hdr *header, 
 				   u16 frame_len, u8 rssi);
 static void atmel_management_timer(u_long a);
 static void atmel_send_command(struct atmel_private *priv, int command, void *cmd, int cmd_size);
 static int atmel_send_command_wait(struct atmel_private *priv, int command, void *cmd, int cmd_size);
-static void atmel_transmit_management_frame(struct atmel_private *priv, struct ieee802_11_hdr *header,
+static void atmel_transmit_management_frame(struct atmel_private *priv, struct ieee80211_hdr *header,
 					    u8 *body, int body_len);
 
 static u8 atmel_get_mib8(struct atmel_private *priv, u8 type, u8 index);
@@ -827,7 +827,7 @@ static void tx_update_descriptor(struct 
 static int start_tx (struct sk_buff *skb, struct net_device *dev)
 {
 	struct atmel_private *priv = netdev_priv(dev);
-	struct ieee802_11_hdr header;
+	struct ieee80211_hdr header;
 	unsigned long flags;
 	u16 buff, frame_ctl, len = (ETH_ZLEN < skb->len) ? skb->len : ETH_ZLEN;
 	u8 SNAP_RFC1024[6] = {0xaa, 0xaa, 0x03, 0x00, 0x00, 0x00};
@@ -863,17 +863,17 @@ static int start_tx (struct sk_buff *skb
 		return 1;
 	}
 	
-	frame_ctl = IEEE802_11_FTYPE_DATA;
+	frame_ctl = IEEE80211_FTYPE_DATA;
 	header.duration_id = 0;
 	header.seq_ctl = 0;
 	if (priv->wep_is_on)
-		frame_ctl |= IEEE802_11_FCTL_WEP;
+		frame_ctl |= IEEE80211_FCTL_WEP;
 	if (priv->operating_mode == IW_MODE_ADHOC) {
 		memcpy(&header.addr1, skb->data, 6);
 		memcpy(&header.addr2, dev->dev_addr, 6);
 		memcpy(&header.addr3, priv->BSSID, 6);
 	} else {
-		frame_ctl |= IEEE802_11_FCTL_TODS;
+		frame_ctl |= IEEE80211_FCTL_TODS;
 		memcpy(&header.addr1, priv->CurrentBSSID, 6);
 		memcpy(&header.addr2, dev->dev_addr, 6);
 		memcpy(&header.addr3, skb->data, 6);
@@ -902,7 +902,7 @@ static int start_tx (struct sk_buff *skb
 }
 
 static void atmel_transmit_management_frame(struct atmel_private *priv, 
-					    struct ieee802_11_hdr *header,
+					    struct ieee80211_hdr *header,
 					    u8 *body, int body_len)
 {
 	u16 buff;
@@ -917,7 +917,7 @@ static void atmel_transmit_management_fr
 	tx_update_descriptor(priv, header->addr1[0] & 0x01, len, buff, TX_PACKET_TYPE_MGMT);
 }
 	
-static void fast_rx_path(struct atmel_private *priv, struct ieee802_11_hdr *header, 
+static void fast_rx_path(struct atmel_private *priv, struct ieee80211_hdr *header, 
 			 u16 msdu_size, u16 rx_packet_loc, u32 crc)
 {
 	/* fast path: unfragmented packet copy directly into skbuf */
@@ -955,7 +955,7 @@ static void fast_rx_path(struct atmel_pr
 	}
 	
 	memcpy(skbp, header->addr1, 6); /* destination address */
-	if (le16_to_cpu(header->frame_ctl) & IEEE802_11_FCTL_FROMDS) 
+	if (le16_to_cpu(header->frame_ctl) & IEEE80211_FCTL_FROMDS) 
 		memcpy(&skbp[6], header->addr3, 6);
 	else
 		memcpy(&skbp[6], header->addr2, 6); /* source address */
@@ -990,14 +990,14 @@ static int probe_crc(struct atmel_privat
 	return (crc ^ 0xffffffff) == netcrc;
 }
 
-static void frag_rx_path(struct atmel_private *priv, struct ieee802_11_hdr *header, 
+static void frag_rx_path(struct atmel_private *priv, struct ieee80211_hdr *header, 
 			 u16 msdu_size, u16 rx_packet_loc, u32 crc, u16 seq_no, u8 frag_no, int more_frags)
 {
 	u8 mac4[6]; 
 	u8 source[6];
 	struct sk_buff *skb;
 
-	if (le16_to_cpu(header->frame_ctl) & IEEE802_11_FCTL_FROMDS) 
+	if (le16_to_cpu(header->frame_ctl) & IEEE80211_FCTL_FROMDS) 
 		memcpy(source, header->addr3, 6);
 	else
 		memcpy(source, header->addr2, 6); 
@@ -1082,7 +1082,7 @@ static void frag_rx_path(struct atmel_pr
 static void rx_done_irq(struct atmel_private *priv)
 {
 	int i;
-	struct ieee802_11_hdr header;
+	struct ieee80211_hdr header;
 	
 	for (i = 0; 
 	     atmel_rmem8(priv, atmel_rx(priv, RX_DESC_FLAGS_OFFSET, priv->rx_desc_head)) == RX_DESC_FLAG_VALID &&
@@ -1117,7 +1117,7 @@ static void rx_done_irq(struct atmel_pri
 		/* probe for CRC use here if needed  once five packets have arrived with
 		   the same crc status, we assume we know what's happening and stop probing */
 		if (priv->probe_crc) {
-			if (!priv->wep_is_on || !(frame_ctl & IEEE802_11_FCTL_WEP)) {
+			if (!priv->wep_is_on || !(frame_ctl & IEEE80211_FCTL_WEP)) {
 				priv->do_rx_crc = probe_crc(priv, rx_packet_loc, msdu_size);
 			} else {
 				priv->do_rx_crc = probe_crc(priv, rx_packet_loc + 24, msdu_size - 24);
@@ -1132,16 +1132,16 @@ static void rx_done_irq(struct atmel_pri
 		}
 		    
 		/* don't CRC header when WEP in use */
-		if (priv->do_rx_crc && (!priv->wep_is_on || !(frame_ctl & IEEE802_11_FCTL_WEP))) {
+		if (priv->do_rx_crc && (!priv->wep_is_on || !(frame_ctl & IEEE80211_FCTL_WEP))) {
 			crc = crc32_le(0xffffffff, (unsigned char *)&header, 24);
 		}
 		msdu_size -= 24; /* header */
 
-		if ((frame_ctl & IEEE802_11_FCTL_FTYPE) == IEEE802_11_FTYPE_DATA) { 
+		if ((frame_ctl & IEEE80211_FCTL_FTYPE) == IEEE80211_FTYPE_DATA) { 
 			
-			int more_fragments = frame_ctl & IEEE802_11_FCTL_MOREFRAGS;
-			u8 packet_fragment_no = seq_control & IEEE802_11_SCTL_FRAG;
-			u16 packet_sequence_no = (seq_control & IEEE802_11_SCTL_SEQ) >> 4;
+			int more_fragments = frame_ctl & IEEE80211_FCTL_MOREFRAGS;
+			u8 packet_fragment_no = seq_control & IEEE80211_SCTL_FRAG;
+			u16 packet_sequence_no = (seq_control & IEEE80211_SCTL_SEQ) >> 4;
 			
 			if (!more_fragments && packet_fragment_no == 0 ) {
 				fast_rx_path(priv, &header, msdu_size, rx_packet_loc, crc);
@@ -1151,7 +1151,7 @@ static void rx_done_irq(struct atmel_pri
 			}
 		}
 		
-		if ((frame_ctl & IEEE802_11_FCTL_FTYPE) == IEEE802_11_FTYPE_MGMT) {
+		if ((frame_ctl & IEEE80211_FCTL_FTYPE) == IEEE80211_FTYPE_MGMT) {
 			/* copy rest of packet into buffer */
 			atmel_copy_to_host(priv->dev, (unsigned char *)&priv->rx_buf, rx_packet_loc + 24, msdu_size);
 			
@@ -2663,10 +2663,10 @@ static void handle_beacon_probe(struct a
  
 static void send_authentication_request(struct atmel_private *priv, u8 *challenge, int challenge_len)
 {
-	struct ieee802_11_hdr header;
+	struct ieee80211_hdr header;
 	struct auth_body auth;
 	
-	header.frame_ctl = cpu_to_le16(IEEE802_11_FTYPE_MGMT | IEEE802_11_STYPE_AUTH); 
+	header.frame_ctl = cpu_to_le16(IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_AUTH); 
 	header.duration_id	= cpu_to_le16(0x8000);	
 	header.seq_ctl = 0;
 	memcpy(header.addr1, priv->CurrentBSSID, 6);
@@ -2677,7 +2677,7 @@ static void send_authentication_request(
 		auth.alg = cpu_to_le16(C80211_MGMT_AAN_SHAREDKEY); 
 		/* no WEP for authentication frames with TrSeqNo 1 */
 		if (priv->CurrentAuthentTransactionSeqNum != 1)
-			header.frame_ctl |=  cpu_to_le16(IEEE802_11_FCTL_WEP); 
+			header.frame_ctl |=  cpu_to_le16(IEEE80211_FCTL_WEP); 
 	} else {
 		auth.alg = cpu_to_le16(C80211_MGMT_AAN_OPENSYSTEM);
 	}
@@ -2701,7 +2701,7 @@ static void send_association_request(str
 {
 	u8 *ssid_el_p;
 	int bodysize;
-	struct ieee802_11_hdr header;
+	struct ieee80211_hdr header;
 	struct ass_req_format {
 		u16 capability;
 		u16 listen_interval; 
@@ -2714,8 +2714,8 @@ static void send_association_request(str
 		u8 rates[4];
 	} body;
 		
-	header.frame_ctl = cpu_to_le16(IEEE802_11_FTYPE_MGMT | 
-		(is_reassoc ? IEEE802_11_STYPE_REASSOC_REQ : IEEE802_11_STYPE_ASSOC_REQ));
+	header.frame_ctl = cpu_to_le16(IEEE80211_FTYPE_MGMT | 
+		(is_reassoc ? IEEE80211_STYPE_REASSOC_REQ : IEEE80211_STYPE_ASSOC_REQ));
 	header.duration_id = cpu_to_le16(0x8000);
 	header.seq_ctl = 0;
 
@@ -2751,9 +2751,9 @@ static void send_association_request(str
 	atmel_transmit_management_frame(priv, &header, (void *)&body, bodysize);
 }
 
-static int is_frame_from_current_bss(struct atmel_private *priv, struct ieee802_11_hdr *header)
+static int is_frame_from_current_bss(struct atmel_private *priv, struct ieee80211_hdr *header)
 {
-	if (le16_to_cpu(header->frame_ctl) & IEEE802_11_FCTL_FROMDS)
+	if (le16_to_cpu(header->frame_ctl) & IEEE80211_FCTL_FROMDS)
 		return memcmp(header->addr3, priv->CurrentBSSID, 6) == 0;
 	else
 		return memcmp(header->addr2, priv->CurrentBSSID, 6) == 0;
@@ -2801,7 +2801,7 @@ static int retrieve_bss(struct atmel_pri
 }
 
 
-static void store_bss_info(struct atmel_private *priv, struct ieee802_11_hdr *header,
+static void store_bss_info(struct atmel_private *priv, struct ieee80211_hdr *header,
 			   u16 capability, u16 beacon_period, u8 channel, u8 rssi, 
 			   u8 ssid_len, u8 *ssid, int is_beacon)
 {
@@ -3085,12 +3085,12 @@ static void atmel_smooth_qual(struct atm
 }
 
 /* deals with incoming managment frames. */
-static void atmel_management_frame(struct atmel_private *priv, struct ieee802_11_hdr *header, 
+static void atmel_management_frame(struct atmel_private *priv, struct ieee80211_hdr *header, 
 		      u16 frame_len, u8 rssi)
 {
 	u16 subtype;
 	
-	switch (subtype = le16_to_cpu(header->frame_ctl) & IEEE802_11_FCTL_STYPE) {
+	switch (subtype = le16_to_cpu(header->frame_ctl) & IEEE80211_FCTL_STYPE) {
 	case C80211_SUBTYPE_MGMT_BEACON :
 	case C80211_SUBTYPE_MGMT_ProbeResponse:
 		
diff --git a/drivers/net/wireless/orinoco.c b/drivers/net/wireless/orinoco.c
--- a/drivers/net/wireless/orinoco.c
+++ b/drivers/net/wireless/orinoco.c
@@ -94,6 +94,8 @@
 #include <net/iw_handler.h>
 #include <net/ieee80211.h>
 
+#include <net/ieee80211.h>
+
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/system.h>
@@ -101,7 +103,6 @@
 #include "hermes.h"
 #include "hermes_rid.h"
 #include "orinoco.h"
-#include "ieee802_11.h"
 
 /********************************************************************/
 /* Module information                                               */
@@ -150,7 +151,7 @@ static const u8 encaps_hdr[] = {0xaa, 0x
 #define ENCAPS_OVERHEAD		(sizeof(encaps_hdr) + 2)
 
 #define ORINOCO_MIN_MTU		256
-#define ORINOCO_MAX_MTU		(IEEE802_11_DATA_LEN - ENCAPS_OVERHEAD)
+#define ORINOCO_MAX_MTU		(IEEE80211_DATA_LEN - ENCAPS_OVERHEAD)
 
 #define SYMBOL_MAX_VER_LEN	(14)
 #define USER_BAP		0
@@ -442,7 +443,7 @@ static int orinoco_change_mtu(struct net
 	if ( (new_mtu < ORINOCO_MIN_MTU) || (new_mtu > ORINOCO_MAX_MTU) )
 		return -EINVAL;
 
-	if ( (new_mtu + ENCAPS_OVERHEAD + IEEE802_11_HLEN) >
+	if ( (new_mtu + ENCAPS_OVERHEAD + IEEE80211_HLEN) >
 	     (priv->nicbuf_size - ETH_HLEN) )
 		return -EINVAL;
 
@@ -918,7 +919,7 @@ static void __orinoco_ev_rx(struct net_d
                    data. */
 		return;
 	}
-	if (length > IEEE802_11_DATA_LEN) {
+	if (length > IEEE80211_DATA_LEN) {
 		printk(KERN_WARNING "%s: Oversized frame received (%d bytes)\n",
 		       dev->name, length);
 		stats->rx_length_errors++;
@@ -2272,7 +2273,7 @@ static int orinoco_init(struct net_devic
 
 	/* No need to lock, the hw_unavailable flag is already set in
 	 * alloc_orinocodev() */
-	priv->nicbuf_size = IEEE802_11_FRAME_LEN + ETH_HLEN;
+	priv->nicbuf_size = IEEE80211_FRAME_LEN + ETH_HLEN;
 
 	/* Initialize the firmware */
 	err = orinoco_reinit_firmware(dev);
diff --git a/drivers/net/wireless/strip.c b/drivers/net/wireless/strip.c
--- a/drivers/net/wireless/strip.c
+++ b/drivers/net/wireless/strip.c
@@ -209,7 +209,7 @@ enum {
 	NoStructure = 0,	/* Really old firmware */
 	StructuredMessages = 1,	/* Parsable AT response msgs */
 	ChecksummedMessages = 2	/* Parsable AT response msgs with checksums */
-} FirmwareLevel;
+};
 
 struct strip {
 	int magic;
diff --git a/drivers/net/wireless/wavelan_cs.c b/drivers/net/wireless/wavelan_cs.c
--- a/drivers/net/wireless/wavelan_cs.c
+++ b/drivers/net/wireless/wavelan_cs.c
@@ -59,6 +59,12 @@
 /* Do *NOT* add other headers here, you are guaranteed to be wrong - Jean II */
 #include "wavelan_cs.p.h"		/* Private header */
 
+#ifdef WAVELAN_ROAMING
+static void wl_cell_expiry(unsigned long data);
+static void wl_del_wavepoint(wavepoint_history *wavepoint, struct net_local *lp);
+static void wv_nwid_filter(unsigned char mode, net_local *lp);
+#endif  /*  WAVELAN_ROAMING  */
+
 /************************* MISC SUBROUTINES **************************/
 /*
  * Subroutines which won't fit in one of the following category
@@ -500,9 +506,9 @@ fee_write(u_long	base,	/* i/o port of th
 
 #ifdef WAVELAN_ROAMING	/* Conditional compile, see wavelan_cs.h */
 
-unsigned char WAVELAN_BEACON_ADDRESS[]= {0x09,0x00,0x0e,0x20,0x03,0x00};
+static unsigned char WAVELAN_BEACON_ADDRESS[] = {0x09,0x00,0x0e,0x20,0x03,0x00};
   
-void wv_roam_init(struct net_device *dev)
+static void wv_roam_init(struct net_device *dev)
 {
   net_local  *lp= netdev_priv(dev);
 
@@ -531,7 +537,7 @@ void wv_roam_init(struct net_device *dev
   printk(KERN_DEBUG "WaveLAN: Roaming enabled on device %s\n",dev->name);
 }
  
-void wv_roam_cleanup(struct net_device *dev)
+static void wv_roam_cleanup(struct net_device *dev)
 {
   wavepoint_history *ptr,*old_ptr;
   net_local *lp= netdev_priv(dev);
@@ -550,7 +556,7 @@ void wv_roam_cleanup(struct net_device *
 }
 
 /* Enable/Disable NWID promiscuous mode on a given device */
-void wv_nwid_filter(unsigned char mode, net_local *lp)
+static void wv_nwid_filter(unsigned char mode, net_local *lp)
 {
   mm_t                  m;
   unsigned long         flags;
@@ -575,7 +581,7 @@ void wv_nwid_filter(unsigned char mode, 
 }
 
 /* Find a record in the WavePoint table matching a given NWID */
-wavepoint_history *wl_roam_check(unsigned short nwid, net_local *lp)
+static wavepoint_history *wl_roam_check(unsigned short nwid, net_local *lp)
 {
   wavepoint_history	*ptr=lp->wavepoint_table.head;
   
@@ -588,7 +594,7 @@ wavepoint_history *wl_roam_check(unsigne
 }
 
 /* Create a new wavepoint table entry */
-wavepoint_history *wl_new_wavepoint(unsigned short nwid, unsigned char seq, net_local* lp)
+static wavepoint_history *wl_new_wavepoint(unsigned short nwid, unsigned char seq, net_local* lp)
 {
   wavepoint_history *new_wavepoint;
 
@@ -624,7 +630,7 @@ wavepoint_history *wl_new_wavepoint(unsi
 }
 
 /* Remove a wavepoint entry from WavePoint table */
-void wl_del_wavepoint(wavepoint_history *wavepoint, struct net_local *lp)
+static void wl_del_wavepoint(wavepoint_history *wavepoint, struct net_local *lp)
 {
   if(wavepoint==NULL)
     return;
@@ -646,7 +652,7 @@ void wl_del_wavepoint(wavepoint_history 
 }
 
 /* Timer callback function - checks WavePoint table for stale entries */ 
-void wl_cell_expiry(unsigned long data)
+static void wl_cell_expiry(unsigned long data)
 {
   net_local *lp=(net_local *)data;
   wavepoint_history *wavepoint=lp->wavepoint_table.head,*old_point;
@@ -686,7 +692,7 @@ void wl_cell_expiry(unsigned long data)
 }
 
 /* Update SNR history of a wavepoint */
-void wl_update_history(wavepoint_history *wavepoint, unsigned char sigqual, unsigned char seq)	
+static void wl_update_history(wavepoint_history *wavepoint, unsigned char sigqual, unsigned char seq)	
 {
   int i=0,num_missed=0,ptr=0;
   int average_fast=0,average_slow=0;
@@ -723,7 +729,7 @@ void wl_update_history(wavepoint_history
 }
 
 /* Perform a handover to a new WavePoint */
-void wv_roam_handover(wavepoint_history *wavepoint, net_local *lp)
+static void wv_roam_handover(wavepoint_history *wavepoint, net_local *lp)
 {
   kio_addr_t		base = lp->dev->base_addr;
   mm_t                  m;
diff --git a/drivers/net/wireless/wavelan_cs.h b/drivers/net/wireless/wavelan_cs.h
--- a/drivers/net/wireless/wavelan_cs.h
+++ b/drivers/net/wireless/wavelan_cs.h
@@ -62,7 +62,7 @@
  * like DEC RoamAbout, or Digital Ocean, Epson, ...), you must modify this
  * part to accommodate your hardware...
  */
-const unsigned char	MAC_ADDRESSES[][3] =
+static const unsigned char	MAC_ADDRESSES[][3] =
 {
   { 0x08, 0x00, 0x0E },		/* AT&T Wavelan (standard) & DEC RoamAbout */
   { 0x08, 0x00, 0x6A },		/* AT&T Wavelan (alternate) */
@@ -79,14 +79,14 @@ const unsigned char	MAC_ADDRESSES[][3] =
  * (as read in the offset register of the dac area).
  * Used to map channel numbers used by `wfreqsel' to frequencies
  */
-const short	channel_bands[] = { 0x30, 0x58, 0x64, 0x7A, 0x80, 0xA8,
+static const short	channel_bands[] = { 0x30, 0x58, 0x64, 0x7A, 0x80, 0xA8,
 				    0xD0, 0xF0, 0xF8, 0x150 };
 
 /* Frequencies of the 1.0 modem (fixed frequencies).
  * Use to map the PSA `subband' to a frequency
  * Note : all frequencies apart from the first one need to be multiplied by 10
  */
-const int	fixed_bands[] = { 915e6, 2.425e8, 2.46e8, 2.484e8, 2.4305e8 };
+static const int	fixed_bands[] = { 915e6, 2.425e8, 2.46e8, 2.484e8, 2.4305e8 };
 
 
 /*************************** PC INTERFACE ****************************/
diff --git a/drivers/net/wireless/wavelan_cs.p.h b/drivers/net/wireless/wavelan_cs.p.h
--- a/drivers/net/wireless/wavelan_cs.p.h
+++ b/drivers/net/wireless/wavelan_cs.p.h
@@ -647,23 +647,6 @@ struct net_local
   void __iomem *mem;
 };
 
-/**************************** PROTOTYPES ****************************/
-
-#ifdef WAVELAN_ROAMING
-/* ---------------------- ROAMING SUBROUTINES -----------------------*/
-
-wavepoint_history *wl_roam_check(unsigned short nwid, net_local *lp);
-wavepoint_history *wl_new_wavepoint(unsigned short nwid, unsigned char seq, net_local *lp);
-void wl_del_wavepoint(wavepoint_history *wavepoint, net_local *lp);
-void wl_cell_expiry(unsigned long data);
-wavepoint_history *wl_best_sigqual(int fast_search, net_local *lp);
-void wl_update_history(wavepoint_history *wavepoint, unsigned char sigqual, unsigned char seq);
-void wv_roam_handover(wavepoint_history *wavepoint, net_local *lp);
-void wv_nwid_filter(unsigned char mode, net_local *lp);
-void wv_roam_init(struct net_device *dev);
-void wv_roam_cleanup(struct net_device *dev);
-#endif	/* WAVELAN_ROAMING */
-
 /* ----------------- MODEM MANAGEMENT SUBROUTINES ----------------- */
 static inline u_char		/* data */
 	hasr_read(u_long);	/* Read the host interface : base address */
diff --git a/drivers/net/wireless/wl3501.h b/drivers/net/wireless/wl3501.h
--- a/drivers/net/wireless/wl3501.h
+++ b/drivers/net/wireless/wl3501.h
@@ -2,7 +2,7 @@
 #define __WL3501_H__
 
 #include <linux/spinlock.h>
-#include "ieee802_11.h"
+#include <net/ieee80211.h>
 
 /* define for WLA 2.0 */
 #define WL3501_BLKSZ 256
@@ -548,7 +548,7 @@ struct wl3501_80211_tx_plcp_hdr {
 
 struct wl3501_80211_tx_hdr {
 	struct wl3501_80211_tx_plcp_hdr	pclp_hdr;
-	struct ieee802_11_hdr		mac_hdr;
+	struct ieee80211_hdr		mac_hdr;
 } __attribute__ ((packed));
 
 /*
diff --git a/drivers/net/wireless/wl3501_cs.c b/drivers/net/wireless/wl3501_cs.c
--- a/drivers/net/wireless/wl3501_cs.c
+++ b/drivers/net/wireless/wl3501_cs.c
@@ -296,7 +296,8 @@ static int wl3501_get_flash_mac_addr(str
  *
  * Move 'size' bytes from PC to card. (Shouldn't be interrupted)
  */
-void wl3501_set_to_wla(struct wl3501_card *this, u16 dest, void *src, int size)
+static void wl3501_set_to_wla(struct wl3501_card *this, u16 dest, void *src,
+			      int size)
 {
 	/* switch to SRAM Page 0 */
 	wl3501_switch_page(this, (dest & 0x8000) ? WL3501_BSS_SPAGE1 :
@@ -317,8 +318,8 @@ void wl3501_set_to_wla(struct wl3501_car
  *
  * Move 'size' bytes from card to PC. (Shouldn't be interrupted)
  */
-void wl3501_get_from_wla(struct wl3501_card *this, u16 src, void *dest,
-			 int size)
+static void wl3501_get_from_wla(struct wl3501_card *this, u16 src, void *dest,
+				int size)
 {
 	/* switch to SRAM Page 0 */
 	wl3501_switch_page(this, (src & 0x8000) ? WL3501_BSS_SPAGE1 :
@@ -1438,14 +1439,14 @@ fail:
 	goto out;
 }
 
-struct net_device_stats *wl3501_get_stats(struct net_device *dev)
+static struct net_device_stats *wl3501_get_stats(struct net_device *dev)
 {
 	struct wl3501_card *this = dev->priv;
 
 	return &this->stats;
 }
 
-struct iw_statistics *wl3501_get_wireless_stats(struct net_device *dev)
+static struct iw_statistics *wl3501_get_wireless_stats(struct net_device *dev)
 {
 	struct wl3501_card *this = dev->priv;
 	struct iw_statistics *wstats = &this->wstats;
diff --git a/drivers/usb/net/Makefile b/drivers/usb/net/Makefile
--- a/drivers/usb/net/Makefile
+++ b/drivers/usb/net/Makefile
@@ -8,5 +8,3 @@ obj-$(CONFIG_USB_PEGASUS)	+= pegasus.o
 obj-$(CONFIG_USB_RTL8150)	+= rtl8150.o
 obj-$(CONFIG_USB_USBNET)	+= usbnet.o
 obj-$(CONFIG_USB_ZD1201)	+= zd1201.o
-
-CFLAGS_zd1201.o = -Idrivers/net/wireless/
diff --git a/drivers/usb/net/zd1201.c b/drivers/usb/net/zd1201.c
--- a/drivers/usb/net/zd1201.c
+++ b/drivers/usb/net/zd1201.c
@@ -21,7 +21,7 @@
 #include <linux/string.h>
 #include <linux/if_arp.h>
 #include <linux/firmware.h>
-#include <ieee802_11.h>
+#include <net/ieee80211.h>
 #include "zd1201.h"
 
 static struct usb_device_id zd1201_table[] = {
@@ -338,25 +338,25 @@ static void zd1201_usbrx(struct urb *urb
 			goto resubmit;
 		}
 			
-		if ((seq & IEEE802_11_SCTL_FRAG) ||
-		    (fc & IEEE802_11_FCTL_MOREFRAGS)) {
+		if ((seq & IEEE80211_SCTL_FRAG) ||
+		    (fc & IEEE80211_FCTL_MOREFRAGS)) {
 			struct zd1201_frag *frag = NULL;
 			char *ptr;
 
 			if (datalen<14)
 				goto resubmit;
-			if ((seq & IEEE802_11_SCTL_FRAG) == 0) {
+			if ((seq & IEEE80211_SCTL_FRAG) == 0) {
 				frag = kmalloc(sizeof(struct zd1201_frag*),
 				    GFP_ATOMIC);
 				if (!frag)
 					goto resubmit;
-				skb = dev_alloc_skb(IEEE802_11_DATA_LEN +14+2);
+				skb = dev_alloc_skb(IEEE80211_DATA_LEN +14+2);
 				if (!skb) {
 					kfree(frag);
 					goto resubmit;
 				}
 				frag->skb = skb;
-				frag->seq = seq & IEEE802_11_SCTL_SEQ;
+				frag->seq = seq & IEEE80211_SCTL_SEQ;
 				skb_reserve(skb, 2);
 				memcpy(skb_put(skb, 12), &data[datalen-14], 12);
 				memcpy(skb_put(skb, 2), &data[6], 2);
@@ -365,7 +365,7 @@ static void zd1201_usbrx(struct urb *urb
 				goto resubmit;
 			}
 			hlist_for_each_entry(frag, node, &zd->fraglist, fnode)
-				if(frag->seq == (seq&IEEE802_11_SCTL_SEQ))
+				if(frag->seq == (seq&IEEE80211_SCTL_SEQ))
 					break;
 			if (!frag)
 				goto resubmit;
@@ -373,7 +373,7 @@ static void zd1201_usbrx(struct urb *urb
 			ptr = skb_put(skb, len);
 			if (ptr)
 				memcpy(ptr, data+8, len);
-			if (fc & IEEE802_11_FCTL_MOREFRAGS)
+			if (fc & IEEE80211_FCTL_MOREFRAGS)
 				goto resubmit;
 			hlist_del_init(&frag->fnode);
 			kfree(frag);
diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -69,6 +69,12 @@ static inline int is_multicast_ether_add
 	return ((addr[0] != 0xff) && (0x01 & addr[0]));
 }
 
+static inline int is_broadcast_ether_addr(const u8 *addr)
+{
+        return ((addr[0] == 0xff) && (addr[1] == 0xff) && (addr[2] == 0xff) &&  
+		(addr[3] == 0xff) && (addr[4] == 0xff) && (addr[5] == 0xff));
+}
+
 /**
  * is_valid_ether_addr - Determine if the given Ethernet address is valid
  * @addr: Pointer to a six-byte array containing the Ethernet address
diff --git a/include/net/ieee80211.h b/include/net/ieee80211.h
--- a/include/net/ieee80211.h
+++ b/include/net/ieee80211.h
@@ -20,7 +20,6 @@
  */
 #ifndef IEEE80211_H
 #define IEEE80211_H
-
 #include <linux/if_ether.h> /* ETH_ALEN */
 #include <linux/kernel.h>   /* ARRAY_SIZE */
 
@@ -426,9 +425,7 @@ struct ieee80211_stats {
 
 struct ieee80211_device;
 
-#if 0 /* for later */
 #include "ieee80211_crypt.h"
-#endif
 
 #define SEC_KEY_1         (1<<0)
 #define SEC_KEY_2         (1<<1)
@@ -852,5 +849,4 @@ static inline const char *escape_essid(c
 	*d = '\0';
 	return escaped;
 }
-
 #endif /* IEEE80211_H */
diff --git a/net/Kconfig b/net/Kconfig
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -212,6 +212,7 @@ endmenu
 source "net/ax25/Kconfig"
 source "net/irda/Kconfig"
 source "net/bluetooth/Kconfig"
+source "net/ieee80211/Kconfig"
 
 endif   # if NET
 endmenu # Networking
diff --git a/net/Makefile b/net/Makefile
--- a/net/Makefile
+++ b/net/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_DECNET)		+= decnet/
 obj-$(CONFIG_ECONET)		+= econet/
 obj-$(CONFIG_VLAN_8021Q)	+= 8021q/
 obj-$(CONFIG_IP_SCTP)		+= sctp/
+obj-$(CONFIG_IEEE80211)		+= ieee80211/
 
 ifeq ($(CONFIG_NET),y)
 obj-$(CONFIG_SYSCTL)		+= sysctl_net.o

--------------040606050705040408010709--
