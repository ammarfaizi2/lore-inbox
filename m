Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265923AbUAKPfP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 10:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265924AbUAKPfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 10:35:15 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:42580 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265923AbUAKPfJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 10:35:09 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Gunter =?iso-8859-1?q?K=F6nigsmann?= <gunter.koenigsmann@gmx.de>
Subject: Re: Synaptics Touchpad workaround for strange behavior after Sync loss (With Patch).
Date: Sun, 11 Jan 2004 10:34:54 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Peter Berg Larsen <pebl@math.ku.dk>
References: <Pine.LNX.4.53.0401110935010.1395@calcula.uni-erlangen.de> <Pine.LNX.4.40.0401111347320.16947-100000@shannon.math.ku.dk> <20040111142213.GB28148@ucw.cz>
In-Reply-To: <20040111142213.GB28148@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200401111034.54789.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 January 2004 09:22 am, Vojtech Pavlik wrote:
> On Sun, Jan 11, 2004 at 01:52:46PM +0100, Peter Berg Larsen wrote:
> > On Sun, 11 Jan 2004, Gunter Königsmann wrote:
> > > Hmmm... Now I get an "Reverted to legacy aux mode" after about
> > > every third resync of the driver, and sometimes odd and sometimes
> > > even numbers of sync losses...
> >
> > How often is that? X/minute. I do not expect many "reverted .."
> > messages, but if there is, then I believe the mux ver 1.1 has added
> > some extra error codes that we se as a revert.
>
> Or the BIOS powermanagement is touching the controller in a way the MUX
> mode doesn't like ...

Does booting with i8042.i8042_nomux=1 help? That should keep the MUX in
legacy mode. (well, depending on the kernel version it's either i8042.nomux
or i8042.i8042_nomux, -mm1 and my patches use former, in 2.6.1 vanilla uses
later form). 

Dmitry
