Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268037AbUHKOPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268037AbUHKOPm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 10:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268069AbUHKOPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 10:15:42 -0400
Received: from styx.suse.cz ([82.119.242.94]:47242 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S268037AbUHKOPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 10:15:33 -0400
Date: Wed, 11 Aug 2004 16:17:11 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Sascha Wilde <wilde@sha-bang.de>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       "David N. Welton" <davidw@eidetix.com>
Subject: Re: 2.6 kernel won't reboot on AMD system - 8042 problem?
Message-ID: <20040811141710.GA2659@ucw.cz>
References: <4107E788.8030903@eidetix.com> <41122C82.3020304@eidetix.com> <200408110131.14114.dtor_core@ameritech.net> <20040811122711.GA5759@ucw.cz> <20040811134316.GA2399@kenny.sha-bang.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811134316.GA2399@kenny.sha-bang.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 03:43:16PM +0200, Sascha Wilde wrote:
> On Wed, Aug 11, 2004 at 02:27:11PM +0200, Vojtech Pavlik wrote:
> > On Wed, Aug 11, 2004 at 01:31:13AM -0500, Dmitry Torokhov wrote:
> > > On Thursday 05 August 2004 07:48 am, David N. Welton wrote:
> > > > By putting a series of 'crashme/reboot' calls into the kernel, I 
> > > > narrowed a possibl cause of it down to this bit of code in 
> > > > drivers/input/serio.c:753
> [...]
> > > Could you please try the patch below? I am interested in tests both with
> > > and without keyboard/mouse. The main idea is to leave ports that have been
> > > disabled by BIOS alone... The patch compiles but otherwise untested. Against
> > > 2.6.7.
> > 
> > Well, this has a problem - plugging a mouse later will never work, as
> > the interface will be disabled by the BIOS if a mouse is not present at
> > boot.
> 
> Is PS/2 supposed to support hotpluging at all?  I guess it's not, but I may
> be wrong...
 
Electrically it's fine - the data and clock lines are pulled-up open-collector.

Protocol-wise it's also OK, each device announces itself after it's
plugged in.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
