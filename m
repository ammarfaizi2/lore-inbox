Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965155AbVKVTtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965155AbVKVTtX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965154AbVKVTtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:49:23 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:2151 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965139AbVKVTtW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:49:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=mszwH+10jO3bIshu34e4IfErHIU0jIhJzYLjjB40m8G0S5MznZpxXq5FWeUYznh7Ync8uuXAX7BY0bsA3Q3EVno17CjPt0mmKsgDx4log+vGTPMEKOyzTKuK5J2RlLv6mAOhH263X9FSdzZq2VbEoSs5KeEsZVNRFz5di5wzJjc=
Date: Tue, 22 Nov 2005 20:49:10 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Avi Kivity <avi@argo.co.il>
Cc: jgarzik@pobox.com, jonsmirl@gmail.com, benh@kernel.crashing.org,
       alan@lxorguk.ukuu.org.uk, airlied@gmail.com, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
Message-Id: <20051122204910.a4bd1d1e.diegocg@gmail.com>
In-Reply-To: <438348BB.1050504@argo.co.il>
References: <20051121225303.GA19212@kroah.com>
	<20051121230136.GB19212@kroah.com>
	<1132616132.26560.62.camel@gaston>
	<21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com>
	<1132623268.20233.14.camel@localhost.localdomain>
	<1132626478.26560.104.camel@gaston>
	<9e4733910511211923r69cdb835pf272ac745ae24ed7@mail.gmail.com>
	<43833D61.9050400@argo.co.il>
	<20051122155143.GA30880@havoc.gtf.org>
	<43834400.3040506@argo.co.il>
	<20051122172650.72f454de.diegocg@gmail.com>
	<438348BB.1050504@argo.co.il>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 22 Nov 2005 18:35:07 +0200,
Avi Kivity <avi@argo.co.il> escribió:


> I don't have a Windows box, but I'm quite sure Windows (without the more 
> esoteric switches) is quite stable, even in SMP. The '95 and NT 4.0 days 
> are gone. Give the drivers the environment they like (mangle the 
> addresses if necessary, single thread them, allow them larger stacks, 
> whatever it takes) and they will work well. Put them in userspace if 
> you're paranoid or isolate them using binary translation.

You seem to miss my point: In a typical windows installation, some
drivers are CRAPPY. It's not about the windows "core". It's the thousand
of crappy drivers made by crappy companies to support cheap devices
which makes it unstable.

The /3GB makes windows to switch to 1GB/3GB mode instead of the default
2GB/2GB. Passing "/PAE /3GB" options to the windows kernel is used by
many people to measure the quality of the drivers - and _many_ times
(specially with cheap hardware) it doesn't work. Some times the box
won't even boot.

The same goes for SMP. Windows is SMP safe, but I bet my ass
that the big majority of drivers made for cheap devices has not
been tested in a smp box - I've seen it myself, my dual p3 box
dies as soon as the dialup app tells the drivers of a cheap 
winmodem I have to do its job.

Which, by the way, is going to be _really_ fun in the windows
world now that people is buying dual-core machines. Thousand of
SMP-unsafe code paths will soon start being tested by millions
of customers buying dual-core CPUs...(and is not that all linux
drivers are or will be better but having the source allows fixing
them...)

>  From this discussion, it looks like the choices of the future are 
> Windows drivers or serial terminals. Excuse me now while I look for my 
> null-modem cable.

You seem to forget linux history: Linux started having _zero_ zupport
for hardware except for a few devices and a single 32 bit architecture.
Right now its the operative system with the biggest number of drivers
on the world (most of windows drivers are not made by microsoft). Linux
has beated companies like nvidia and ati in this field many times and
can do it again.
