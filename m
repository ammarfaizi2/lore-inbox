Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265030AbUETHto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265030AbUETHto (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 03:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbUETHto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 03:49:44 -0400
Received: from zork.zork.net ([64.81.246.102]:64395 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S265030AbUETHtm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 03:49:42 -0400
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       vojtech@suse.cz
Subject: Re: Scroll wheel on PS/2 Logitech MouseMan Wheel no longer works
 (was Re: 2.6.6-mm3)
References: <20040516025514.3fe93f0c.akpm@osdl.org>
	<200405171310.16761.dtor_core@ameritech.net>
	<6u4qqejiny.fsf@zork.zork.net>
	<200405191256.32335.dtor_core@ameritech.net>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
 linux-kernel@vger.kernel.org,  Andrew Morton <akpm@osdl.org>,
 vojtech@suse.cz
Date: Thu, 20 May 2004 08:49:35 +0100
In-Reply-To: <200405191256.32335.dtor_core@ameritech.net> (Dmitry Torokhov's
 message of "Wed, 19 May 2004 12:56:31 -0500")
Message-ID: <6uy8nnczcg.fsf@zork.zork.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> writes:

> On Tuesday 18 May 2004 02:31 am, Sean Neakums wrote:
>> Dmitry Torokhov <dtor_core@ameritech.net> writes:
>> 
>> > My Intellimouse Explorer (USB) wheel seems to be working fine so mousedev
>> > changes should be ok...  Would you mind compiling evbug module and telling
>> > me what events the wheel generates?
>> 
>> Here's what logged for up and down respectively:
>> 
>>   evbug.c: Event. Dev: isa0060/serio1/input0, Type: 2, Code: 0, Value: 222
>>   evbug.c: Event. Dev: isa0060/serio1/input0, Type: 2, Code: 1, Value: -15
>>   evbug.c: Event. Dev: isa0060/serio1/input0, Type: 0, Code: 0, Value: 0
>> 
>>   evbug.c: Event. Dev: isa0060/serio1/input0, Type: 2, Code: 0, Value: 214
>>   evbug.c: Event. Dev: isa0060/serio1/input0, Type: 2, Code: 1, Value: -1
>>   evbug.c: Event. Dev: isa0060/serio1/input0, Type: 0, Code: 0, Value: 0
>>
>
> Hmm... it indeed reports REL_X and REL_Y events instead of REL_WHEEL... So
> its definitely not a mousedev problem. Could you also try booting with
> psmouse.proto=exps and see if it still behaves sanely?

The scrolls wheel appears to do nothing when I boot with psmouse.proto=exps.
Here's what the mouse is shown as in /proc/bus/input/devices:

  I: Bus=0011 Vendor=0002 Product=0006 Version=0000
  N: Name="ImExPS/2 Generic Explorer Mouse"
  P: Phys=isa0060/serio1/input0
  H: Handlers=mouse0 
  B: EV=7 
  B: KEY=1f0000 0 0 0 0 0 0 0 0 
  B: REL=103 

> Btw, when you boot without psmouse.proto option what poduct/version is shown
> in /proc/bus/input/devices?

With no psmouse.proto set, it shows up as:

  I: Bus=0011 Vendor=0002 Product=0006 Version=0050
  N: Name="ImExPS/2 Logitech Wheel Mouse"
  P: Phys=isa0060/serio1/input0
  H: Handlers=mouse0 
  B: EV=7 
  B: KEY=1f0000 0 0 0 0 0 0 0 0 
  B: REL=103 

