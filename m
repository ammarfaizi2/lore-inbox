Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262586AbVCPNtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262586AbVCPNtX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 08:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262588AbVCPNtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 08:49:23 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:35846 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262586AbVCPNtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 08:49:16 -0500
Message-ID: <42383A27.9060101@aitel.hist.no>
Date: Wed, 16 Mar 2005 14:52:39 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Scheidegger <rscheidegger_lists@hispeed.ch>
CC: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: Another drm/dri lockup - when moving the mouse
References: <423802E6.1020308@aitel.hist.no> <423822FA.6020501@hispeed.ch>
In-Reply-To: <423822FA.6020501@hispeed.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Scheidegger wrote:

> Helge Hafting wrote:
>
>> I have reported this before, but now I have some more data.
>>
>> I have an office pc with this video card:
>> VGA compatible controller: ATI Technologies Inc Radeon RV100 QY 
>> [Radeon 7000/VE]
>>
>> In previous reports I found that starting xfree or xorg with dri support
>> cause a hang after a little while.  It seems that this only happens when
>> the mouse moves.  Something I didn't discover before because there
>> are lots of unplanned mouse movements - the thing is sensitive and jumps
>> a pixel now and then when I move stuff on the desk.
>
> What xorg / xfree / drm versions are you talking about?

Any version.  It has been like this for years with all versions of xfree 
from debian testing,
so I have simply given up using 3D on this particular machine.  I also tried
downloading and compiling x.org 6.8.1 to have a look at transparency
and shadows.  Transparency worked - dri crashed as usual.  At the moment,
I use the debian package xserver-xfree86-dri-trunk which contains the
x.org server (not the xfree one).  My current kernel is 2.6.11-mm3.

>
>> Taking care not to move the mouse, I can start X and run glxgears
>> with acceleration.  The slightest mouse movement during 3D activity
>> kills the machine instantly so it only responds to the reset button.  
>> Mouse
>> movement without 3D activity may or may not kill the pc.
>>
>> Could there be a problem where 3D-stuff and code to move the mouse
>> "steps on each other toes" somehow?  Or some way to test this further,
>> by disabling the mouse or force some kind of software fallback for
>> the mouse cursor?
>
> You could use Option "SWcursor" "true".

Thanks, I'll try that.

> Since it crashes even without 3d sometimes, the problem does not seem 
> to be related to dri (as in, dri driver).

Stable as rock, _if_  Load "dri" is commented out from xorg.conf (or 
from XF86Config-4)

> Sounds more like it's related to CP activity. Not sure what would 
> cause this, there seem to be a lot of mouse cursor movement crashes 
> reported lately... Do you have a USB mouse whose controller shares the 
> IRQ with the graphic card maybe?

No usb.  The mouse is connected to the ps/2 mouse port.  As I mentioned, 
this is
not a recent problem.  I could never load dri on this machine without
such a crash.  I can check whether the IRQ gets shared though.

Helge Hafting
