Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266425AbUFUTeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266425AbUFUTeR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 15:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266422AbUFUTeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 15:34:17 -0400
Received: from smtpout.ev1.net ([207.44.129.135]:58116 "EHLO smtpout.ev1.net")
	by vger.kernel.org with ESMTP id S266431AbUFUTeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 15:34:06 -0400
Date: Mon, 21 Jun 2004 14:32:53 -0500
From: Michael Langley <nwo@hacked.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with psmouse detecting generic ImExPS/2
Message-Id: <20040621143253.759e21c1.nwo@hacked.org>
In-Reply-To: <20040621183459.GA1969@ucw.cz>
References: <20040621021651.4667bf43.nwo@hacked.org>
	<20040621082831.GC1200@ucw.cz>
	<20040621124506.18b1f67a.nwo@hacked.org>
	<20040621183459.GA1969@ucw.cz>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2004 20:34:59 +0200
Vojtech Pavlik <vojtech@suse.cz> wrote:

> On Mon, Jun 21, 2004 at 12:45:06PM -0500, Michael Langley wrote:
> > On Mon, 21 Jun 2004 10:28:31 +0200
> > Vojtech Pavlik <vojtech@suse.cz> wrote:
> > 
> > > On Mon, Jun 21, 2004 at 02:16:51AM -0500, Michael Langley wrote:
> > > > I noticed this after upgrading 2.6.6->2.6.7
> > > > 
> > > > Even after building psmouse as a module, and specifying the protocol,
> > > > all I get is an ImPS/2 Generic Wheel Mouse.
> > > > 
> > > > [root@purgatory root]# modprobe psmouse proto=exps
> > > > Jun 21 01:51:57 purgatory kernel: input: ImPS/2 Generic Wheel Mouse on
> > > > isa0060/serio1
> > > > 
> > > > My ImExPS/2 was detected correctly in <=2.6.6 and after examining the
> > > > current psmouse code, and the changes in patch-2.6.7, I can't figure out
> > > > what's breaking it.  A little help?
> > >  
> > > Maybe your mouse needs the ImPS/2 init before the ExPS/2 one. You can
> > > try to copy and-paste the ImPS/2 init once more in the code, without a
> > > return, of course.
> > > 
> > > -- 
> > > Vojtech Pavlik
> > > SuSE Labs, SuSE CR
> > 
> > 
> > Right.  That did the trick.
> 
> > [root@purgatory root]# modprobe psmouse proto=exps
> > Jun 21 12:41:36 purgatory kernel: input: ImExPS/2 Generic Wheel Mouse on isa0060/serio1
> > 
> > Much thanks for the help.  I couldn't live without the extra buttons in X.
> 
> Can you check if this patch fixes it for you as well?
> 
> -- 
> Vojtech Pavlik
> SuSE Labs, SuSE CR
> 

Indeed, it does.  And much more efficiently.  Thanks again.
