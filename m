Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbTIYLV5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 07:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTIYLV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 07:21:56 -0400
Received: from mail2.uu.nl ([131.211.16.76]:2197 "EHLO mail2.uu.nl")
	by vger.kernel.org with ESMTP id S261806AbTIYLVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 07:21:55 -0400
Subject: more header annoyances
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: kraxel@bytesex.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1064488998.2228.516.camel@shrek.bitfreak.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 25 Sep 2003 13:23:18 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,

/usr/src/linux-2.6.x/include/media/id.h says "/* FIXME: this
temporarely, until these are included in linux/i2c-id.h */". Since these
are now in i2c-id.h, could you consider removing that file?

Reason:
-
#include <media/tuner.h>
#include <linux/i2c.h>
-
...(in a driver) will break compilation...
-
include/linux/i2c-id.h:79:1: warning: "I2C_DRIVERID_TDA9875" redefined
In file included from include/media/tuner.h:25,
                 from drivers/media/video/zr36120.c:42:
include/media/id.h:19:1: warning: this is the location of the previous
definition
-

Thanks,

Ronald

PS I hope I'm not annoying you with all these small issues, I'm just
trying to find & solve issues that I notice in 2.6.x while doing some
random work on it. :).

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>
Linux Video/Multimedia developer

