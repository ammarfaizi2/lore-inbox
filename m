Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbTDHPK3 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 11:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbTDHPK3 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 11:10:29 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:30472 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S261830AbTDHPK2 (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 11:10:28 -0400
Date: Tue, 8 Apr 2003 17:22:00 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "Kevin P. Fleming" <kpfleming@cox.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <3E91FEF8.20207@cox.net>
Message-ID: <Pine.LNX.4.44.0304081706520.12110-100000@serv>
References: <200303311541.50200.pbadari@us.ibm.com> <Pine.LNX.4.44.0304031256550.5042-100000@serv>
 <20030403133725.GA14027@win.tue.nl> <Pine.LNX.4.44.0304031548090.12110-100000@serv>
 <b6s3tm$i2d$1@cesium.transmeta.com> <Pine.LNX.4.44.0304071742490.12110-100000@serv>
 <Pine.LNX.4.44.0304072351110.12110-100000@serv> <3E91FEF8.20207@cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 7 Apr 2003, Kevin P. Fleming wrote:

> However, there are significant hurdles to implementing this tool:
> 
> - defining an adequately powerful file format to define the desired naming policy

The kernel only exports information, which you can get from sysfs. This 
will unlikely become a requirement for 2.6, so how this done can still 
change a bit.

> - getting the tool to run _both_ in early-userspace and real-userspace 
> environments, using the _same_ policy file (or copies thereof)

Early-userspace is not that much of a problem, as it only has to map 
the device information from sysfs to a device name. The required 
configuration file can be quite simple, every device has a list of 
properties, which closely resembles sysfs (one property == one value).

bye, Roman

