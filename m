Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVAWREk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVAWREk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 12:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVAWREk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 12:04:40 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:6871 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261331AbVAWREj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 12:04:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=kwSXxOYQ1uJ5pwxLyFPMQYLvh2xgAxMtdZweVf350iWP3L/cRme43FPKKW+A4Uho+NbV2cKba0a5Dn6QhySja++EztWJ+2zCchaNCeKb+ZOSlhRXIaLv6DPLrW7bqD8lgeuZMCOUGhizslYf+52spEHQlMi8VmPEOlPsHbhjmOQ=
Message-ID: <9e4733910501230904468439c3@mail.gmail.com>
Date: Sun, 23 Jan 2005 12:04:38 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: udev and raw1394/video1394 drivers
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The raw1394 and video1394 device drivers aren't creating their sysfs
dev nodes. Since these are missing udev can't create /dev/raw1394 and
/dev/video1394/*.  This complicates getting camcorders running on udev
distributions like Fedora Core 3. I searched the archives and one
partial patch for this was proposed but it doesn't look like it got
accepted. Is this being worked on?

Easy work around: MAKEDEV raw1394 video1394, but try telling that to a
newbie. Google search shows many people having this problem. There is
a Redhat bug for this too.

-- 
Jon Smirl
jonsmirl@gmail.com
