Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268195AbTALA5o>; Sat, 11 Jan 2003 19:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268196AbTALA5o>; Sat, 11 Jan 2003 19:57:44 -0500
Received: from pcp01184434pcs.strl301.mi.comcast.net ([68.60.187.197]:2014
	"EHLO mythical") by vger.kernel.org with ESMTP id <S268195AbTALA5m>;
	Sat, 11 Jan 2003 19:57:42 -0500
Date: Sat, 11 Jan 2003 20:06:21 -0500
From: Ryan Anderson <ryan@michonline.com>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: The GPL, the kernel, and everything else.
Message-ID: <20030112010621.GD12020@michonline.com>
Mail-Followup-To: Linux kernel list <linux-kernel@vger.kernel.org>
References: <7BFCE5F1EF28D64198522688F5449D5A03C0F4@xchangeserver2.storigen.com> <1042250324.1278.18.camel@RobsPC.RobertWilkens.com> <20030111020738.GC9373@work.bitmover.com> <1042251202.1259.28.camel@RobsPC.RobertWilkens.com> <20030111021741.GF9373@work.bitmover.com> <1042252717.1259.51.camel@RobsPC.RobertWilkens.com> <20030111214437.GD9153@nbkurt.casa-etp.nl> <1042322012.1034.6.camel@RobsPC.RobertWilkens.com> <20030111233633.A17042@ucw.cz> <1042325870.1034.45.camel@RobsPC.RobertWilkens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042325870.1034.45.camel@RobsPC.RobertWilkens.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(subject changed to make Andre happy. :)

I'm also certain replying is a bad idea... *sigh* but anyway...

On Sat, Jan 11, 2003 at 05:57:50PM -0500, Rob Wilkens wrote:
> On Sat, 2003-01-11 at 17:36, Vojtech Pavlik wrote:
> 
> Per your comment, re: hardware changing over time, why can't linux just
> come up with a nice binary plug-in driver architecture (ok, it has
> kernel modules, but from one compile of a kernel to another, the modules
> aren't portable).  If there were a module plug-in architecture, the
> kernel code wouldn't have to change much to support new hardware.

Because, to a large extent, for the core kernel developers, the existing
system is fine.

Nobody wants to design an API/ABI that is big, covers all possible
cases, and is excessively complex.  The API that modules ( and drivers )
use is designed to solve the current problem space.  When a new feature,
driver or problem needs to be added or fixed, the problem space has
changed, and the interface changes a little bit in turn.  Usually (not
always), the person that changed the interface cycles through the
drivers that are in the tree, and fixes them up.  (The cases where this
doesn't happen are, I believe, generally ones where two different but
related interfaces coexist for a long period of time, and as the older
interface is phased out, there is a semi-painful transition period.)

> A little "design time" up front (in other words) would save a lot of
> coding time later...

What makes you think that design doesn't occur?  Read through the OLS
papers to understand just how many talented people *are* doing design.
The difference may be that, on this list, you see a active work in
progress.  ("Stream of consciousness" might not be a bad analogy)

> Also -- Why hasn't there been a move to something like CVS for the
> kernel -- perhaps with linus being the cvs 'god' or whatever the person
> who authorizes changes to the code is called.  This way you get to
> always have the latest code, and check the changes back in without using
> an ancient mail text-based interface, and you can describe your changes
> (which get forever stored with the change), and changes can always be
> backed out.  Remember, I'm a newbie, so point me to the FAQ if this is
> there.

There is, but it's not CVS.  CVS has... issues when you get into complex
project structures (not so much the complexity of the code - but how the
projects are managed).  CVS wouldn't permit the decentralized nature of
development on other archictures in quite the same manner as the tool
Linus *has* chosen to use - BitKeeper.  (And no - that's not meant to be
an advertisement for BK so much as an acknowledgement that CVS collapses
under branching nightmares.)

Now, this thread should be well and truly dead soon, with any luck.  I
know I'm going to try to resist perpetuating it.


-- 

Ryan Anderson
  sometimes Pug Majere
