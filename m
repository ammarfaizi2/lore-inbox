Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVCBXwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVCBXwW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVCBXvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:51:18 -0500
Received: from gate.crashing.org ([63.228.1.57]:27088 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261320AbVCBXgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:36:09 -0500
Subject: Re: [PATCH 3/3] openfirmware: implements hotplug for macio devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeffrey Mahoney <jeffm@suse.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050301211828.GD16465@locomotive.unixthugs.org>
References: <20050301211828.GD16465@locomotive.unixthugs.org>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 10:33:37 +1100
Message-Id: <1109806417.5610.124.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-01 at 16:18 -0500, Jeffrey Mahoney wrote:
> This patch adds the hotplug routine for generating hotplug events when
> devices are seen on the macio bus. It uses the attributed created by the
> sysfs nodes to generate the hotplug environment vars for userspace.
> 
> In order for hotplug to work with macio devices, patches to module-init-tools
> and hotplug must be applied. Those patches are available at:
> 
> ftp://ftp.suse.com/pub/people/jeffm/linux/macio-hotplug/

Ok, looks good too. It would be interesting to convert the media-bay
stuff to use hotplug now too :) But that mean some serious work on swim3
and ide-pmac to make them more hotplug friendly... Not sure it's worth
the pain. The current mecanism actually works, even if it's not pretty,
and mediabay-based machines are a thing of the past.

Ben.


