Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262023AbSLPXH4>; Mon, 16 Dec 2002 18:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262040AbSLPXH4>; Mon, 16 Dec 2002 18:07:56 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:17162 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262023AbSLPXHz>; Mon, 16 Dec 2002 18:07:55 -0500
Date: Tue, 17 Dec 2002 00:15:51 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Metolious hardware-sensors-using-ACPI specs
Message-ID: <20021216231551.GH20773@atrey.karlin.mff.cuni.cz>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A5AB@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A5AB@orsmsx119.jf.intel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > But... Metolious sounds *needed*; how do you access voltage sensors
> > without metolious, in a way that can coexist with ACPI thermal
> > support?
> 
> (I think you mean thermal sensors)

No, I mean voltage sensors. They are on same smbus as thermal sensors,
yet their are not normally accessible using ACPI. I can talk to smbus
controller directly, but acpi may decide to read temperature while I'm
reading voltage, leading to armagedon.

How is that solved?

> A solution in search of a problem. I can say this because I helped define
> it. :)

Well, I thought that "simple" specs looks reasonable, I did not look
at "advanced" metolious. But it seemed sane (*).

> The machines that care about manageability (servers) appear to be entirely
> disjoint from the ones that have thermal zones (and, servers use IPMI),
> therefore thermal chip contention doesn't happen. And, Metolious required a
> fair amount of AML code.

I have seen desktop machine that can control CPU fan (altrough it is
slow/fast not on/off) and has thermal zone. It would be nice to be
able to check voltages in a safe way...
							Pavel

(*) comapred to ACPI2.0 ;-).
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
