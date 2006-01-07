Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030351AbWAGFCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbWAGFCu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 00:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbWAGFCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 00:02:50 -0500
Received: from smtp107.sbc.mail.re2.yahoo.com ([68.142.229.98]:34386 "HELO
	smtp107.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030351AbWAGFCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 00:02:49 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: request for opinion on synaptics, adb and powerpc
Date: Sat, 7 Jan 2006 00:02:46 -0500
User-Agent: KMail/1.8.3
Cc: Peter Osterlund <petero2@telia.com>, Luca Bigliardi <shammash@artha.org>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <20060106231301.GG4732@kamaji.shammash.lan> <1136609048.4840.210.camel@localhost.localdomain> <200601062346.30987.dtor_core@ameritech.net>
In-Reply-To: <200601062346.30987.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601070002.47255.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 January 2006 23:46, Dmitry Torokhov wrote:
> On Friday 06 January 2006 23:44, Benjamin Herrenschmidt wrote:
> > On Fri, 2006-01-06 at 23:36 -0500, Dmitry Torokhov wrote:
> > > On Friday 06 January 2006 23:33, Benjamin Herrenschmidt wrote:
> > > > 
> > > > > Why would you want to switch to relative mode when leaving X? As far as
> > > > > I know the only other mouse "user" out there is GPM and there are patches
> > > > > available for it to use event device:
> > > > > 
> > > > > 	http://geocities.com/dt_or/gpm/gpm.html
> > > > > 
> > > > > Unfortunately the maintainer can't find time to merge these so they were
> > > > > sitting there for over 2 years. FWIW Fedora patches their GPM with these.
> > > > 
> > > > gpm among other legacy things ...
> > > > 
> > > 
> > > What other legacy things? And in that case I think manually forcing protocol
> > > back to relative would be an option.
> > > 
> > > The thing is that Synaptics in absolute and relative mode is 2 completely
> > > different devices with different capabilities. If you want to switch mode
> > > you really need to kill old input device and create a brand new one.
> > 
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
> 

Oh, yes, another option for legacy applications would be to use GPM's
repeater mode.

-- 
Dmitry
