Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264625AbSKVLuC>; Fri, 22 Nov 2002 06:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264630AbSKVLuC>; Fri, 22 Nov 2002 06:50:02 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:45316 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S264625AbSKVLuB>; Fri, 22 Nov 2002 06:50:01 -0500
Date: Fri, 22 Nov 2002 12:56:25 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Miles Bader <miles@gnu.org>
cc: Adrian Bunk <bunk@fs.tum.de>, <linux-kernel@vger.kernel.org>
Subject: Re: New kconfig: Please add define_*
In-Reply-To: <buon0o2fine.fsf@mcspd15.ucom.lsi.nec.co.jp>
Message-ID: <Pine.LNX.4.44.0211221241460.2113-100000@serv>
References: <20021121133320.GD18869@fs.tum.de> <Pine.LNX.4.44.0211211740130.2113-100000@serv>
 <buon0o2fine.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> I'd like to be able to override a prompt.
> 
> The reason is that in general it's nice for the arch-specific Kconfig
> file to include various other Kconfig files (using `source'), but
> sometimes an option that usually makes sense as user-definable -- and
> thus has a prompt -- _doesn't_ make sense on that particular
> architecture.

Do you have a specific example? What I've seen so far (especially cris was 
full of it), was more used to override the user (and only worked with 
'make oldconfig' anyway). Only because most users want to include specific 
drivers, doesn't mean all users have to include these drivers. I'm a bit 
afraid such a feature would be easily misused.
It sounds more like you want an autoconf, which generates a machine 
specific config. E.g. ppc already delivers several config files for 
different machines, which are selected with 'make <mach>_config'. Going 
into this direction sounds like a better idea.

bye, Roman

