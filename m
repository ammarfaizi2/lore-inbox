Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVCVN7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVCVN7F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 08:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVCVN7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 08:59:05 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:56696 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261239AbVCVN6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 08:58:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=cO/cRc0/7PvdQY44IuzbUD307tpuooyMODLdYckyn+mATbfe7ZshlBBLYwqXQ4mwoImOJmVuI+UEe8ni/lyP6JD3E0m/ENJOMD1UAIsb7797W6xRF+LZjy5LerB+JVAH+R8r0F3jDNhiUOVRuXgzOjLhq4ZqVbWDR5EndpH8Eic=
Message-ID: <d120d50005032205584fd37a94@mail.gmail.com>
Date: Tue, 22 Mar 2005 08:58:48 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Patrick McFarland <pmcfarland@downeast.net>
Subject: Re: alsa es1371's joystick functionality broken in 2.6.11-mm4
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200503220706.13029.pmcfarland@downeast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <200503201557.58055.pmcfarland@downeast.net>
	 <200503212241.26780.pmcfarland@downeast.net>
	 <200503212249.09512.dtor_core@ameritech.net>
	 <200503220706.13029.pmcfarland@downeast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005 07:06:07 -0500, Patrick McFarland
<pmcfarland@downeast.net> wrote:
> On Monday 21 March 2005 10:49 pm, Dmitry Torokhov wrote:
> > On Monday 21 March 2005 22:41, Patrick McFarland wrote:
> >
> > Ok, it looks like setup problem. Try doing:
> >
> >  modprobe snd-ens1371 joystick_port=1
> 
> I already tried that before I mailed the great and almighty source of all
> information kernely (aka the lkml). Infact, I tried both joystick=1 and
> joystick_port=1 (some drivers use one, others use the other, and I wasn't
> sure at the time which es1371 used).
> 
> It didn't work.
> 

Ok, just so I know where we stand: your gameport/joystick does work in
plain 2.6.11 but does not in 2.6.11-mm4, correct? When you load the
module with "joystick_port=1" is there any messages from ens1371 in
dmesg? Have you tried specifying exact port, like
"joystick_port=0x200" or "joystick_port=0x218"? Do you see these ports
reserved in /proc/ioports? What about /sys/bus/gameport/devices/? Do
you see anything in that directory?

-- 
Dmitry
