Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbVBXISm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbVBXISm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 03:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbVBXISm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 03:18:42 -0500
Received: from mta11.adelphia.net ([68.168.78.205]:51632 "EHLO
	mta11.adelphia.net") by vger.kernel.org with ESMTP id S261900AbVBXISk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 03:18:40 -0500
Message-ID: <421D8D58.5060602@nodivisions.com>
Date: Thu, 24 Feb 2005 03:16:24 -0500
From: Anthony DiSante <theant@nodivisions.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: mouse still losing sync and thus jumping around
References: <421C83A2.9040502@vollwerbung.at> <d120d50005022308536d29dab7@mail.gmail.com> <421D4460.6050308@nodivisions.com> <200502232218.56665.dtor_core@ameritech.net>
In-Reply-To: <200502232218.56665.dtor_core@ameritech.net>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
>>In Oct 2004 I posted to lkml with subject "KVM -> jumping mouse... still no 
>>solution?"  Dmitry Torokhov (hi :) responded that this would work on 2.6.9-rc3+:
>>
>>	echo -n "reconnect" > /sys/bus/serio/devices/serioX/driver
>>
>>That was GREAT and it worked for a while, but now my last few 2.6.10 kernels 
>>don't seem to care when I do that, and again, unplugging the mouse is the 
>>only thing that works.  I'm currently running 2.6.10-gentoo-r6.
>>
> 
> 
> It still should work fine, but in a bit different form:
> 
> 	echo -n "reconnect" > /sys/bus/serio/devices/serioX/drvctl
> 
> I.e. substitute "driver" with "drvctl" as now "driver" is a symlink to
> a currently bound driver that is set up by driver core.

Ah, sweet, thank you.  This should all be documented somewhere!  For now 
I've been keeping my notes here:

http://nodivisions.com/tech/linux/jumpingmouse/

-Anthony DiSante
http://nodivisions.com/
