Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbVJSQB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbVJSQB2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 12:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbVJSQB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 12:01:28 -0400
Received: from ctb-mesg2.saix.net ([196.25.240.82]:48639 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S1751134AbVJSQB2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 12:01:28 -0400
Message-ID: <43566DCE.5040705@geograph.co.za>
Date: Wed, 19 Oct 2005 18:01:18 +0200
From: Zoltan Szecsei <zoltans@geograph.co.za>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: multiple independent keyboard kernel support
References: <4316E5D9.8050107@geograph.co.za> <20050911223414.GA19403@aitel.hist.no>
In-Reply-To: <20050911223414.GA19403@aitel.hist.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helga (et al),

I'm just back on this issue and am trying to make changes to the basic 
xorg.conf without yet connecting the 2nd VGA,Kyb & mouse.

I thought if I set up a template for the config then it would be easier 
to copy & make changes for when I connect the 2nd KVM devices.

I'm having a problem with the "Dev Phys" option as I keep getting:
(EE) Generic Keyboard: cannot register with evdev brain
No core keyboard.

(man xorg.conf does not show "Dev Phys" - should it not be "Device" ??

The real issue is that I cannot find the keyboard device in /dev/input 
(Ubuntu 5.04 )
In /dev/input I only have 6 devices: event0, 1 and 2; mice, mouse0 and ts0

Are you able to tell me what parameter to put in this Option "Dev Phys" ?

TIA,
Zoltan



Helge Hafting wrote:

>xorg from debian testing or from ubuntu already support multiple
>independent keyboards.  I'm using that right now for my
>two-user single-pc setup.
>
>Each independent xserver have a section like this in the xorg.conf:
>Section "InputDevice"
>        Identifier      "Generic Keyboard"
>        Driver          "kbd"
>        Option          "Protocol"      "evdev"
>        Option          "Dev Phys"      "isa0060/serio0/input0"
>        Option          "CoreKeyboard"
>        Option          "XkbRules"      "xfree86"
>        Option          "XkbModel"      "pc102"
>        Option          "XkbLayout"     "no"
>EndSection
>
>  
>
-- 

==================================
Geograph (Pty) Ltd
P.O. Box 31255
Tokai
7966
Tel:    +27-21-7018492
Fax:	+27-86-6115323
Mobile: +27-83-6004028
==================================


