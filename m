Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266884AbUHCWF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266884AbUHCWF2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 18:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUHCWF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 18:05:28 -0400
Received: from zeus.kernel.org ([204.152.189.113]:36071 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S266896AbUHCWFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 18:05:05 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: NFS-mounted, read-only /dev unusable in 2.6
Date: Tue, 3 Aug 2004 21:09:52 +0000 (UTC)
Organization: Cistron Group
Message-ID: <ceouv0$7s8$2@news.cistron.nl>
References: <410F481C.9090408@bio.ifi.lmu.de> <64bf.410f9d6f.62af@altium.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1091567392 8072 62.216.29.200 (3 Aug 2004 21:09:52 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <64bf.410f9d6f.62af@altium.nl>,
Dick Streefland <dick.streefland@altium.nl> wrote:
>Frank Steiner <fsteiner-mail@bio.ifi.lmu.de> wrote:
>| Or is there any other way to get an initial console or
>| output any messages from an init script if one boots via nfsroot
>| and  / (and thus, /dev) is only exported read-only from the
>| server?
>
>You can boot with a ramdisk as root, initialized with an initrd, and
>then perform all NFS mounts manually in the init script. You can use
>pivot_root to switch to an NFS root to get rid of the ramdisk.

If having /dev mounted read-only means you cannot open devices
like /dev/console read/write then that is a bug in the NFS client
in the kernel.

On all other filesystems (ext2, ext3, xfs etc) there's no problem
opening devices r/w on a read-only filesystem.

Mike.
-- 
The question is, what is a "manamanap".
The question is, who cares ?

