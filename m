Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265736AbTA2MQp>; Wed, 29 Jan 2003 07:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265815AbTA2MQp>; Wed, 29 Jan 2003 07:16:45 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:56456 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S265736AbTA2MQp>; Wed, 29 Jan 2003 07:16:45 -0500
Date: Wed, 29 Jan 2003 13:25:50 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Martin Mares <mj@ucw.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] in drivers/char/joystick/magellan.c
Message-ID: <20030129122550.GA25502@wohnheim.fh-wedel.de>
References: <20030128175757.GA22145@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33L2.0301281045250.30636-100000@dragon.pdx.osdl.net> <20030128220353.A2892@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030128220353.A2892@ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 January 2003 22:03:53 +0100, Vojtech Pavlik wrote:
> On Tue, Jan 28, 2003 at 10:47:35AM -0800, Randy.Dunlap wrote:
> > 
> > An array of character type may be initialized by a character string
> > literal, optionally enclosed in braces. Successive characters of the
> > character string literal (including the terminating null character if
> > there is room or if the array is of unknown size) initialize the
> > elements of the array.
> 
> Which means it was OK.

Agreed. objdump -s gives the following:

 0040 30414233 44353647 48393a4b 3c4d4e3f  0AB3D56GH9:K<MN?
 0050 ffffffff 00000000 60010000 e0010000  ........`.......

So gcc does follow the spec here. (redhat gcc 2.96)

Thank you for the clarification, Martin and Randy.

Jörn

-- 
"Security vulnerabilities are here to stay."
-- Scott Culp, Manager of the Microsoft Security Response Center, 2001
