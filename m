Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316693AbSFURZh>; Fri, 21 Jun 2002 13:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316695AbSFURZg>; Fri, 21 Jun 2002 13:25:36 -0400
Received: from sm11.texas.rr.com ([24.93.35.42]:18148 "EHLO sm11.texas.rr.com")
	by vger.kernel.org with ESMTP id <S316693AbSFURZf>;
	Fri, 21 Jun 2002 13:25:35 -0400
Date: Fri, 21 Jun 2002 12:25:37 -0500 (CDT)
From: Jeff Meininger <jeffm@boxybutgood.com>
X-X-Sender: jeffm@spaz.localdomain
To: linux-kernel@vger.kernel.org
Subject: loopback block device 'offset' - 2GB limit?
Message-ID: <Pine.LNX.4.44.0206211200150.2157-100000@spaz.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If someone makes an image of their hard drive with 'dd', and wants to
mount a partition on that image, they can do losetup -o
offset-to-partition-start and it will work fine.  This is good for the
first partition, or any partition starting under 2GB.  Is there a way to
do this for a partition starting ABOVE 2 GB into the image?

struct loop_info has a 32-bit 'int' offset (for x86 anyway), so it might
require something tricky.  I've tried stringing loop devices into a chain,
such that the first loop device starts at some offset, and another loop
device uses the first loop device as the source while specifying another
offset, but this (of course) doesn't work.

Is this possible with a standard linux kernel?

Thanks...
-Jeff Meininger

