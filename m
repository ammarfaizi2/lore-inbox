Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264360AbTDXAbq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 20:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264362AbTDXAbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 20:31:45 -0400
Received: from almesberger.net ([63.105.73.239]:47366 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S264360AbTDXAbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 20:31:44 -0400
Date: Wed, 23 Apr 2003 21:43:33 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Jamie Lokier <jamie@shareable.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Matthias Schniedermeyer <ms@citd.de>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>, pat@suwalski.net
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030423214332.H3557@almesberger.net>
References: <21660000.1051114998@[10.10.2.4]> <20030423164558.GA12202@citd.de> <1508310000.1051116963@flay> <20030423183413.C1425@almesberger.net> <1560860000.1051133781@flay> <20030423191427.D3557@almesberger.net> <1570840000.1051136330@flay> <20030424001134.GD26806@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424001134.GD26806@mail.jlokier.co.uk>; from jamie@shareable.org on Thu, Apr 24, 2003 at 01:11:34AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Even when the microphone is disabled, you still get (a) the sound of
> nearby mobile phone radio signals (my laptop is very bad for this),
> (b) a scary load "pop" as the sound system pulses the speaker.  This
> is particularly bad with powered external speakers, as you wonder
> whether it is good for them.

Good points.

>    A standard audio module option "volume=X" meaning "set volume X%
>    when the module initialises".

I don't quite see how this would make user space any less
fancy:

# insmod audio_driver volume=`retrieve_volume`

versus

# insmod audio_driver
# aumix -L >/dev/null

only that the latter can do a lot more, so you may want it even
if the module lets you set the volume. And the module solution
doesn't help with monolithic kernels. (And I doubt you'd want
this to be a kernel command line parameter. Talk about fancy.)

> Then anything with a fancy enough userspace [...]

echo 'aumix -L >/dev/null' >>/etc/rc.d/rc.local

Wow, that was hard :-) (Okay, things get a tad more complex if
you have more than one mixer.)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
