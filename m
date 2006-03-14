Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751962AbWCNBTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbWCNBTX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 20:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751985AbWCNBTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 20:19:23 -0500
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:41680 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S1751962AbWCNBTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 20:19:23 -0500
Date: Mon, 13 Mar 2006 20:25:03 -0500
From: Adam Belay <ambx1@neo.rr.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Andrew Morton <akpm@osdl.org>, drzeus-list@drzeus.cx,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PNP] 'modalias' sysfs export
Message-ID: <20060314012503.GA22354@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Andrew Morton <akpm@osdl.org>,
	drzeus-list@drzeus.cx, linux-kernel@vger.kernel.org
References: <4412F53B.5010309@drzeus.cx> <20060311173847.23838981.akpm@osdl.org> <4414033F.2000205@drzeus.cx> <20060312172332.GA10278@vrfy.org> <20060312145543.194f4dc7.akpm@osdl.org> <20060313041458.GA13605@vrfy.org> <20060313060221.GA20178@neo.rr.com> <20060313062112.GA15720@vrfy.org> <20060313072654.GB20569@neo.rr.com> <20060313073612.GA16509@vrfy.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060313073612.GA16509@vrfy.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 08:36:12AM +0100, Kay Sievers wrote:
> On Mon, Mar 13, 2006 at 02:26:54AM -0500, Adam Belay wrote:
> > I did some research, and interestingly enough, the ACPI _CID method allows
> > for compatible IDs even for PCI devices.  These also would present a problem
> > for the modalias sysfs attribute.
> 
> Again, you can do every "advanced" setup already today with poking
> around in the bind/unbind files in sysfs. Userspace just receives an
> event from the kernel and can do whatever it wants to do with the event:
> ignore it, load a specific module, start a userspace driver, or just ask
> modprobe to load the kernel supplied default module.
> 
> The modalias is just a convenient way to provide a "default" module
> autoloading and is not expected to become a system management
> replacement with full featured policy integration. I don't really see
> a "real world" problem here. If some day we support this stuff and need
> a new interface we can just do this if someone proposes a better
> solution. For now modalias works just fine. As long as we have device
> table matches _in_ the kernel modules, there is no reason not to export
> the match value from the kernel at the same time.
> 
> Thanks,
> Kay

Alright, I was just trying to make it clear that there are minor problems
with hotplug and some aspects of ACPI, PCMCIA, PNP, etc.  Some of the
exceptions (e.g. multiple PnP IDs) are more common than others (e.g. ACPI
_CID methods for non-acpi devices).  Also, some aren't difficult to work
around with things like the script that parses the "id" attribute.  I'm
interested in seeing how future solutions might attempt to implement these
features, even the corner cases.  I agree, though, that having a simplistic
default like the modalias approach has an important "real world" advantage.

Thanks,
Adam
