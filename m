Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287562AbSAEHEU>; Sat, 5 Jan 2002 02:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287565AbSAEHEA>; Sat, 5 Jan 2002 02:04:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7174 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287562AbSAEHD4>; Sat, 5 Jan 2002 02:03:56 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ISA slot detection on PCI systems?
Date: 4 Jan 2002 23:03:24 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a168fs$p9q$1@cesium.transmeta.com>
In-Reply-To: <20020103144904.A644@zapff.research.canon.com.au> <E16M75s-0008Bz-00@the-village.bc.nu> <20020103133912.B17280@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020103133912.B17280@suse.cz>
By author:    Vojtech Pavlik <vojtech@suse.cz>
In newsgroup: linux.dev.kernel
> 
> It's still not very nice for userspace apps to touch hardware directly,
> even if it's just BIOS memory ...
> 

Red herring.  It's not very nice for *applications* to not indirect
through a driver, but if that driver is in userspace or kernel space
is irrelevant.  Incidentally, "applications" here include a lot of the
parsers that produce /proc output.  /proc/pci is occationally handy,
but it is also an example on why you shouldn't do data reduction in
kernel space unless you can avoid it.  Now /proc/bus/pci is available
and contains all the data, however.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
