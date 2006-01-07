Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030481AbWAGFsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030481AbWAGFsV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 00:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030480AbWAGFsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 00:48:21 -0500
Received: from gate.crashing.org ([63.228.1.57]:34445 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030478AbWAGFsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 00:48:20 -0500
Subject: Re: request for opinion on synaptics, adb and powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Peter Osterlund <petero2@telia.com>, Luca Bigliardi <shammash@artha.org>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <200601062346.30987.dtor_core@ameritech.net>
References: <20060106231301.GG4732@kamaji.shammash.lan>
	 <200601062336.26035.dtor_core@ameritech.net>
	 <1136609048.4840.210.camel@localhost.localdomain>
	 <200601062346.30987.dtor_core@ameritech.net>
Content-Type: text/plain
Date: Sat, 07 Jan 2006 16:49:03 +1100
Message-Id: <1136612944.4840.212.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Ok, so what method should we use to "switch" ? sysfs isn't quite an
> > option yet as the ADB bus isn't yet represented there (unless we add
> > attributes to the input object, but that's a bit awkward as it would be
> > destroyed and re-created if I follow you). A module option would work
> > but adbhid isn't a module, thus that would basically end up as a static
> > kernel argument, unless the driver "polls" the module param regulary to
> > trigger the change.. I don't think there is a way for a driver to get a
> > callback when /sys/module/<driver>/parameters/* changes is there ?
> > 
> 
> Yes, there is, but I'd imagine static option would be just fine. After
> all you either use legacy applications or you don't. And if mousedev
> does not provide adequate emulation you switch to relative mothod.

I still don't like static options... it's always wrong to require
rebooting for whatever reason ...

Ben.


