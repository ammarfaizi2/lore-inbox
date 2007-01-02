Return-Path: <linux-kernel-owner+w=401wt.eu-S1755266AbXABOPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266AbXABOPy (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 09:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754852AbXABOPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 09:15:53 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:37466 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754848AbXABOPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 09:15:53 -0500
X-Greylist: delayed 1242 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jan 2007 09:15:53 EST
From: Mark Hlawatschek <hlawatschek@atix.de>
Organization: ATIX GmbH
To: linux-kernel@vger.kernel.org
Subject: mount --bind and /proc/mounts
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Date: Tue, 2 Jan 2007 14:55:32 +0100
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701021455.32683.hlawatschek@atix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using a shared root environment and therefore linked /etc/mtab 
to /proc/mounts. In addition I'm using --bind mount to make administration 
easier.

Now I found the following behaviour:
# mount -a 
is mounting all filesystems with bind options in the fstab 
everytime the command "mount -a " is executed. 

That works fine using an /etc/mtab file, but fails for --bind mounts 
using /etc/mtab linked to /proc/mounts.

I think this is because /etc/mtab has information about the source directory 
and /proc/mounts shows the device, hosting the filesystem.

e.g.
# mount --bind /tmp/bmount/ /mnt/bmount/
# cat /etc/mtab
(...) /tmp/bmount /mnt/bmount none rw,bind 0 0
# cat /proc/mounts
(...) /dev/root /mnt/bmount ext3 rw,data=ordered 0 0

Is there a solution for this ?
 
Thanks,

Mark




