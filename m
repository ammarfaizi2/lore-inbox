Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264920AbTARQij>; Sat, 18 Jan 2003 11:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264938AbTARQij>; Sat, 18 Jan 2003 11:38:39 -0500
Received: from CPE0080c6e90c22-CM014280010574.cpe.net.cable.rogers.com ([24.43.161.4]:21511
	"EHLO CPE014280010574.cpe.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S264920AbTARQii>; Sat, 18 Jan 2003 11:38:38 -0500
Subject: Re: Devlabel: static device naming via symlinks (improved)
From: Jeremy Jackson <jerj@coplanar.net>
To: Gary_Lerhaupt@Dell.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20BF5713E14D5B48AA289F72BD372D68011A4264@AUSXMPC122.aus.amer.dell.com>
References: <20BF5713E14D5B48AA289F72BD372D68011A4264@AUSXMPC122.aus.amer.dell.com>
Content-Type: text/plain
Organization: 
Message-Id: <1042908456.1735.2.camel@contact.skynet.coplanar.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 18 Jan 2003 11:47:36 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been using EVMS (http://evms.sourceforge.net and it's snapshot
capability (as well as LVM's I assume) can create "partitions" or
volumes with duplicate fs UUIDs.  Perhaps someone using EVMS may not use
devlabel since it includes that functionality, but in the LVM case you
may want to investigate the effect of duplicate UUIDs.

Regards,

Jeremy

On Fri, 2003-01-17 at 17:15, Gary_Lerhaupt@Dell.com wrote:
> I've added a couple useful features to devlabel (available at
> http://domsch.com/linux/devlabel).  Of the foremost of these is that it now
> includes the usage of Partition UUIDs (as provided by ext2, ext3, xfs, jfs
> or ocfs).  Since these UUIDs are partition specific, if a partition-level
> failure event occurs (eg. you delete /dev/sde6 and /dev/sde7 then becomes
> /dev/sde6), devlabel is now smart enough to handle it for the aforementioned
> filesystem types.  If you aren't using one of these filesystem types or if
> there is no filesystem at all, devlabel will then fall back on using SCSI
> UUIDs or IDE identifiers as it used before (these support disk-wide
> failures, when /dev/sdb6 becomes /dev/sda6).
> 
> As well, devlabel now also supports automounting.  For example, with a USB
> flash reader, you should now add it to devlabel with the --automount option.
> If --automount is specified, every time you hotplug your device, it will
> check /etc/fstab for an entry containing the symlink that you've added for
> this device, and if it finds one, it will automatically mount it.  Nice and
> simple.
> 
> Lastly, you can also now do adds by UUID.  This is especially helpful in
> shared storage environments.  For example, you can add a symlink on the
> master node and then add by UUID on all the secondary nodes to ensure that
> the same symlink on all nodes points to the same shared storage device
> regardless of the device naming scheme of those nodes.
> 
> Gary Lerhaupt
> Linux Development
> Dell Computer Corporation
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Jeremy Jackson <jerj@coplanar.net>

