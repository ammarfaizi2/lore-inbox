Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbSJYWWj>; Fri, 25 Oct 2002 18:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261668AbSJYWWi>; Fri, 25 Oct 2002 18:22:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34315 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261638AbSJYWTw>; Fri, 25 Oct 2002 18:19:52 -0400
Date: Fri, 25 Oct 2002 23:25:50 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Scott Murray <scottm@somanetworks.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Greg KH <greg@kroah.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       KOCHI Takayoshi <t-kouchi@mvf.biglobe.ne.jp>, jung-ik.lee@intel.com,
       tony.luck@intel.com,
       pcihpd-discuss <pcihpd-discuss@lists.sourceforge.net>,
       linux-ia64@linuxia64.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Pcihpd-discuss] Re: PCI Hotplug Drivers for 2.5
Message-ID: <20021025232550.B25082@flint.arm.linux.org.uk>
Mail-Followup-To: Scott Murray <scottm@somanetworks.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Greg KH <greg@kroah.com>, Jeff Garzik <jgarzik@pobox.com>,
	KOCHI Takayoshi <t-kouchi@mvf.biglobe.ne.jp>, jung-ik.lee@intel.com,
	tony.luck@intel.com,
	pcihpd-discuss <pcihpd-discuss@lists.sourceforge.net>,
	linux-ia64@linuxia64.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021025193725.A3300@jurassic.park.msu.ru> <Pine.LNX.4.33.0210251754290.17433-100000@rancor.yyz.somanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0210251754290.17433-100000@rancor.yyz.somanetworks.com>; from scottm@somanetworks.com on Fri, Oct 25, 2002 at 06:02:31PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 06:02:31PM -0400, Scott Murray wrote:
> Unfortunately, my take on the scheme used to reserve space for CardBus
> bridges was that it only works on platforms that use the setup-*.c code
> to do their complete PCI subsystem initialization.  On platforms like
> x86, where the BIOS configures all the devices, something like my patch
> is needed to fixup things to handle the desired reservation.  I'm not
> finished getting things ported to 2.5 yet, I'll post a patch ASAP once
> I've got everything workin.  If you're keen on devising an alternative
> method, check put my old patch against 2.4.19 at:

I've been working on this in 2.5 this week - I've got something working,
Alan's happy with the concept as far as the resource allocation goes.

The cardbus reservation method is actually flawed in setup-*.c if you
want to get rid of the stuff in yenta.c - again, I've fixed this lot
in my 2.5 tree already, and the patch is pending an update to the x86
code to do what yenta.c was doing (only setup bridge resources of the
ones already programmed are bad/wrong.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

