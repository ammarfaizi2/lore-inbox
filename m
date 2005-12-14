Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbVLNQNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbVLNQNE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 11:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbVLNQNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 11:13:04 -0500
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:1416 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S932101AbVLNQND
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 11:13:03 -0500
Message-ID: <43A04497.203@de.ibm.com>
Date: Wed, 14 Dec 2005 17:13:11 +0100
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org
Subject: [patch 0/6] statistics infrastructure
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set replaces s390-statistics-infrastructure.patch in the -mm tree.

The common code component proposed makes a unified and inexpensive way
for providing statistics available to kernel programmers, particularly
device driver programmers. It comes with an architecture independent and
exploiter (device driver) independent user interface and allows users to
adjust gathering and processing of statistics data to their needs.

Patch 5/6 contains more detailed information in the form of a
Documentation/ file.

The most important change since s390-statistics-infrastructure.patch is
that the code doesn't just seem to be quite generic, but really is generic.

I have worked through the list of improvements pointed out by Andrew in the
following lkml thread
http://marc.theaimsgroup.com/?l=linux-kernel&m=113050865300184&w=2

Furthermore, I spend some extra time on comments and I fixed
some bugs, mostly related to allocation and NULL-pointer issues.

I am posting a patch for the zfcp driver, as well, which would
be the first exploiter of the statistics infrastructure. Actually, the
zfcp driver has been my test vehicle.

Patch set is against 2.6.15-rc5-git4.

Please keep me on cc: since I am not subscribed to lkml.

List of patches:

[patch 1/6] statistics infrastructure - prerequisite: scatter-gather ringbuffer
[patch 2/6] statistics infrastructure - prerequisite: parser enhancement
[patch 3/6] statistics infrastructure - prerequisite: list operation
[patch 4/6] statistics infrastructure - prerequisite: timestamp
[patch 5/6] statistics infrastructure
[patch 6/6] statistics infrastructure - exploitation: zfcp

