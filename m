Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265390AbUFBXp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265390AbUFBXp2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 19:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbUFBXp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 19:45:28 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:27009 "EHLO cloud.ucw.cz")
	by vger.kernel.org with ESMTP id S265390AbUFBXnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 19:43:04 -0400
Date: Thu, 3 Jun 2004 01:44:28 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Derek Chen-Becker <derek@chen-becker.org>
Cc: Kim Holviala <kim@holviala.com>, linux-kernel@vger.kernel.org
Subject: Re: Troubleshooting PS/2 mouse in 2.6.5
Message-ID: <20040602234428.GE1366@ucw.cz>
References: <408D4CB4.4070901@chen-becker.org> <200404270849.23397.kim@holviala.com> <408E64EB.6080204@chen-becker.org> <408E68C9.5010102@chen-becker.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408E68C9.5010102@chen-becker.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 08:06:01AM -0600, Derek Chen-Becker wrote:
> OK, this is weird. I changed psmouse to be a module and now it works (I 
> also made gameport a module). Here's /proc/bus/input/devices from when 
> it *didn't* work:
> 
> I: Bus=0011 Vendor=0002 Product=0005 Version=0000
> N: Name="ImPS/2 Generic Wheel Mouse"
> P: Phys=isa0060/serio1/input0
> H: Handlers=mouse0
> B: EV=7
> B: KEY=70000 0 0 0 0 0 0 0 0
> B: REL=103
> 
> I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
> N: Name="AT Translated Set 2 keyboard"
> P: Phys=isa0060/serio0/input0
> H: Handlers=kbd
> B: EV=120003
> B: KEY=4 2000000 3802078 f840d001 f2ffffdf ffefffff ffffffff fffffffe
> B: LED=7
> 
> 
> And here's from when it *does* work:
> 
> I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
> N: Name="AT Translated Set 2 keyboard"
> P: Phys=isa0060/serio0/input0
> H: Handlers=kbd
> B: EV=120003
> B: KEY=4 2000000 3802078 f840d001 f2ffffdf ffefffff ffffffff fffffffe
> B: LED=7
> 
> I: Bus=0011 Vendor=0002 Product=0005 Version=0000
> N: Name="ImPS/2 Generic Wheel Mouse"
> P: Phys=isa0060/serio1/input0
> H: Handlers=mouse0
> B: EV=7
> B: KEY=70000 0 0 0 0 0 0 0 0
> B: REL=103
> 
> The only difference I can see is the ordering. Does the mouse handler 
> have to be initialized after the keyboard handler?

No, but on many machines it needs to be initalized after USB.

-- 
