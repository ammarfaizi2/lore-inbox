Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290881AbSBFWuZ>; Wed, 6 Feb 2002 17:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290882AbSBFWso>; Wed, 6 Feb 2002 17:48:44 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:16398 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S290860AbSBFWqr>;
	Wed, 6 Feb 2002 17:46:47 -0500
Date: Wed, 6 Feb 2002 13:16:27 +0100
From: Pavel Machek <pavel@suse.cz>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        Patrick Mochel <mochel@osdl.org>
Subject: Re: driverfs support for motherboard devices
Message-ID: <20020206121627.GA446@elf.ucw.cz>
In-Reply-To: <20020205173912.GA165@elf.ucw.cz> <Pine.LNX.4.44.0202060921380.8308-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0202060921380.8308-100000@netfinity.realnet.co.sz>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +static void __init init_8259A_devicefs(void)
> > +{
> > +	device_register(&device_i8259A);
> > +	strcpy(device_i8259A.name, "i8259A");
> > +	strcpy(device_i8259A.bus_id, "0020");
> > +	device_i8259A.parent = &sys_iobus;
> 
> I'm not entirely familiar with the driverfs API but wouldn't an API 
> function to do all that strcpy and other init assignments be a bit 
> cleaner? I see lots of retyping going on otherwise, someone feel free to 
> hit me with a clue bat if i'm missing something...

I guess that's okay. We do not helper with 1000 arguments to fill
structure up. It will be strcpy sometimes, sprintf
sometimes.... Better leave that alone.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
