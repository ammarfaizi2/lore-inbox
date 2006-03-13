Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751949AbWCMHgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbWCMHgO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 02:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbWCMHgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 02:36:14 -0500
Received: from soundwarez.org ([217.160.171.123]:13788 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751949AbWCMHgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 02:36:14 -0500
Date: Mon, 13 Mar 2006 08:36:12 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Adam Belay <ambx1@neo.rr.com>, Andrew Morton <akpm@osdl.org>,
       drzeus-list@drzeus.cx, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PNP] 'modalias' sysfs export
Message-ID: <20060313073612.GA16509@vrfy.org>
References: <44082E14.5010201@drzeus.cx> <4412F53B.5010309@drzeus.cx> <20060311173847.23838981.akpm@osdl.org> <4414033F.2000205@drzeus.cx> <20060312172332.GA10278@vrfy.org> <20060312145543.194f4dc7.akpm@osdl.org> <20060313041458.GA13605@vrfy.org> <20060313060221.GA20178@neo.rr.com> <20060313062112.GA15720@vrfy.org> <20060313072654.GB20569@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060313072654.GB20569@neo.rr.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 02:26:54AM -0500, Adam Belay wrote:
> I did some research, and interestingly enough, the ACPI _CID method allows
> for compatible IDs even for PCI devices.  These also would present a problem
> for the modalias sysfs attribute.

Again, you can do every "advanced" setup already today with poking
around in the bind/unbind files in sysfs. Userspace just receives an
event from the kernel and can do whatever it wants to do with the event:
ignore it, load a specific module, start a userspace driver, or just ask
modprobe to load the kernel supplied default module.

The modalias is just a convenient way to provide a "default" module
autoloading and is not expected to become a system management
replacement with full featured policy integration. I don't really see
a "real world" problem here. If some day we support this stuff and need
a new interface we can just do this if someone proposes a better
solution. For now modalias works just fine. As long as we have device
table matches _in_ the kernel modules, there is no reason not to export
the match value from the kernel at the same time.

Thanks,
Kay
