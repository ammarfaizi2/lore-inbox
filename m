Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270949AbTGPQpF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 12:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270957AbTGPQpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 12:45:05 -0400
Received: from main.gmane.org ([80.91.224.249]:56254 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S270949AbTGPQo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 12:44:56 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Input layer demand loading
Date: Wed, 16 Jul 2003 18:56:03 +0200
Message-ID: <yw1x65m2mmvw.fsf@users.sourceforge.net>
References: <200307131839.49112.fredrik@dolda2000.cjb.net> <200307141258.24458.fredrik@dolda2000.cjb.net>
 <20030716042916.GC3929@kroah.com>
 <200307161457.42862.fredrik@dolda2000.cjb.net>
 <20030716162639.GB7513@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:hofSci+miGAGwNLm+Q2P7bagI0Y=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

>> Not necessarily. When the joystick is plugged in, you want to load the 
>> hardware driver modules. There's really no need for the userspace interface 
>> until someone requests it. At least that's the way I see it.
>> And in any case, even if you do want to load joydev.o when the joystick is 
>> plugged in, I don't see how that could be done on-demand when the joystick 
>> port isn't hotplug compatible, such as is the case with gameports, right?
>
> True, but then if you try to open the port, you will only get the base
> joydev.o module loaded, not the gameport driver, which is what you
> _really_ want to have loaded, right?
>
> So there really isn't much benifit to doing this, sorry.

That's easily fixed in modules.conf, or modprobe.conf for 2.6.

-- 
Måns Rullgård
mru@users.sf.net

