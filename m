Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263532AbTJaThT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 14:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263533AbTJaThT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 14:37:19 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:54144 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S263532AbTJaThR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 14:37:17 -0500
Message-ID: <3FA2B7D4.5010707@pacbell.net>
Date: Fri, 31 Oct 2003 11:28:20 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: Greg KH <greg@kroah.com>, vojtech@suse.cz,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
References: <200310272235.h9RMZ9x1000602@napali.hpl.hp.com>	<20031028013013.GA3991@kroah.com>	<200310280300.h9S30Hkw003073@napali.hpl.hp.com>	<3FA12A2E.4090308@pacbell.net>	<16289.29015.81760.774530@napali.hpl.hp.com>	<16289.55171.278494.17172@napali.hpl.hp.com>	<3FA28C9A.5010608@pacbell.net> <16290.43822.444275.360988@napali.hpl.hp.com>
In-Reply-To: <16290.43822.444275.360988@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
>>>>>>On Fri, 31 Oct 2003 08:23:54 -0800, David Brownell <david-b@pacbell.net> said:
> 
> 
>   David.B> David Mosberger wrote:
>   >> After spending a bit more time on this, it looks to me like the
>   >> keyboard is crashing the system very early on.
> 
>   David.B> I think there are some devices that choke the HID
>   David.B> code;
> 
> And nobody is alarmed by this?  Surely crashing the kernel by plugging
> in a USB device must be considered a MUST-FIX item.  Perhaps I missed
> something, but I never saw this mentioned before.

You sound alarmed!  If that's alarmed enough to find out what
the real problem is, maybe you'll end up fixing it ... :)

I could be wrong about the problem being in the HID code, but
that does look like a likely home for the bug.  We know there
are other issues with HID/input/hiddev/... that need attention.


>  Having said that, out of
> that 6 or so devices, that particular keyboard is the only one causing
> crashes.  However, note that it works (mostly) fine under 2.4 and even
> if they keyboard were total crap, it certainly shouldn't crash the
> kernel.

Agreed, oopsing == bad.  HID needs more attention.  I suspect whoever
dives into that will want to know what you mean by "(mostly) fine";
that might give a clue about what 2.6 changes worsened the failures.

- Dave

