Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270634AbRIFNLt>; Thu, 6 Sep 2001 09:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270640AbRIFNLo>; Thu, 6 Sep 2001 09:11:44 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:6408 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S270634AbRIFNKz>; Thu, 6 Sep 2001 09:10:55 -0400
Date: Thu, 6 Sep 2001 15:11:13 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Andi Kleen <ak@suse.de>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
Message-ID: <20010906151113.A29583@maggie.dt.e-technik.uni-dortmund.de>
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010905170037.A6473@emma1.emma.line.org.suse.lists.linux.kernel> <20010905152738.C5912BC06D@spike.porcupine.org.suse.lists.linux.kernel> <20010905182033.D3926@emma1.emma.line.org.suse.lists.linux.kernel> <oupg0a1wi9x.fsf@pigdrop.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <oupg0a1wi9x.fsf@pigdrop.muc.suse.de>; from ak@suse.de on Wed, Sep 05, 2001 at 21:26:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen schrieb am Mittwoch, den 05. September 2001:

> Even if it checked the address it would not be unique because you can
> have multiple interfaces with the same addresses but different
> netmasks.  The SIOCGIFNETMASK interface is just broken. If you really

Well, I cannot configure the same address/netmask pair more than once
for the same interface, I'm getting "file exists" back from the ip
command. FreeBSD looks up the name/address pair.

> wanted it you should use rtnetlink instead, which allows multiple
> answers to a single question.  Likely postfix doesn't really need it
> though, the concept of checking for "local" address is pretty dubious
> and likely to be incorrect for many cases.

Well, Postfix used to look at the addresses and deduce the network class
for that, but there have been many complaints by people that this would
get subnets wrong. A couple of months ago, Postfix has started to look
up the netmasks as well.

-- 
Matthias Andree
