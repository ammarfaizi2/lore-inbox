Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030425AbWBHOzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030425AbWBHOzW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 09:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030426AbWBHOzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 09:55:22 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:10717 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1030425AbWBHOzW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 09:55:22 -0500
Message-ID: <43EA079A.4010108@aitel.hist.no>
Date: Wed, 08 Feb 2006 16:00:42 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: fsck: i_blocks is xxx should be yyy on ext3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today I rebooted into 2.6.16-rc2-mm1.  Fsck checked a "clean" ext3 fs,
because it was many mounts since the last time.

I have seen that many times, but this time I got a lot of
"i_blocks is xxx, should be yyy fix?"

In all cases, the blocks were fixed to a lower number.

I did a init 1, and checked the other filesystems.
It was the same everywhere, some i_blocks had do be fixed, and
the superblock was last updated in the future.

Is this normal somehow, or has something strange happened to ext3 lately?
I have experimented with the "barrier" option, but it gets disabled
because barrier based sync fails on the devices.  May this cause silent
errors? I thought I simply didn't get the advantages of barriers.
data=writeback made no difference from the default data=journal,
all filesystems had these wrong i_blocks.

Helge Hafting
