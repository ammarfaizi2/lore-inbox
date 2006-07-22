Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbWGVTlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWGVTlS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 15:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWGVTlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 15:41:18 -0400
Received: from imf16aec.mail.bellsouth.net ([205.152.59.64]:31114 "EHLO
	imf16aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S1751010AbWGVTlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 15:41:17 -0400
Subject: [RFC] GPU device layer patchset (00/07)
From: Louis E Garcia II <louisg00@bellsouth.net>
To: linux-kernel@vger.kernel.org, airlied@gmail.com
Content-Type: text/plain
Date: Sat, 22 Jul 2006 15:40:57 -0400
Message-Id: <1153597257.3358.26.camel@soncomputer>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe their is some confusion over the use of graphics and video. It
might seem logical to use video for video cards but we also have another
use of video for video capture. The source tree has the drm
under /drivers/video but /sys has class/graphics for fb and
class/drm. /dev has /drm /fb.

Is is possible to clean some of this up? Since you are starting on a
rework can you put the gpu device layer source under /drivers/graphics
and maybe move the drm to /drivers/graphics/drm? Frame buffer could
possibly be moved under graphics too. 

The gpu layer can register /sys/class/graphics and udev can still
create /dev/dri/cardX and /dev/fbX. We can create a new dev node
maybe /dev/graphics/cardX or /dev/graphics/{drmX,fbX} for transition.

I really don't want to get in the middle of this as I am not that
technical but I wanted to share my thoughts.

-Louis

