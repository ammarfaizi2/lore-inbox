Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbUKDOEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbUKDOEN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 09:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbUKDOEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 09:04:13 -0500
Received: from pop.gmx.net ([213.165.64.20]:48068 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262222AbUKDOEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 09:04:09 -0500
X-Authenticated: #21910825
Message-ID: <418A36CD.2030600@gmx.net>
Date: Thu, 04 Nov 2004 15:03:57 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6) Gecko/20040114
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC] randomized major and minor numbers
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

IIRC it was debated during 2.5 development to make the kernel
hand out randomized major/minor numbers to better test handling
of dynamic major/minor numbers. Is there a patch available
to test?

Background: I want to make sure that userspace can handle
arbitrary device numbers for disks in my quest for a unified
/dev/diskXpY naming and numbering scheme. This would unify
all the different naming schemes (hd*, sd*, ub*, etc.),
remove arbitrary limits like 15 partitions max on SCSI disks
and achieve most of this in userspace with udev.

In the end, there would be only one block major number >256
with dynamically allocated major numbers for all disks in the
system if LANANA agrees with such a concept. Why would I
want a major >256 registered? Because that way we can make
sure the software accessing these devices can handle a large
dev_t and it doesn't only work by luck.

Comments?

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
