Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263394AbTC2Hbf>; Sat, 29 Mar 2003 02:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263395AbTC2Hbf>; Sat, 29 Mar 2003 02:31:35 -0500
Received: from cpe-024-033-021-148.midsouth.rr.com ([24.33.21.148]:10624 "EHLO
	braindead") by vger.kernel.org with ESMTP id <S263394AbTC2Hbd>;
	Sat, 29 Mar 2003 02:31:33 -0500
From: Warren Turkal <wturkal@cbu.edu>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] laptop keyboard, tracked to ACPI
Date: Sat, 29 Mar 2003 01:42:27 -0600
User-Agent: KMail/1.5.1
References: <200303220605.54478.wturkal@cbu.edu> <200303232056.06284.wturkal@cbu.edu> <200303280828.20070.felix.seeger@gmx.de>
In-Reply-To: <200303280828.20070.felix.seeger@gmx.de>
Cc: andrew.grover@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303290142.27551.wturkal@cbu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me if you reply to the list as I am not on the list.

Andy Grover, ACPI Maintainer, I am CCing you directly as I think this is your 
bug at this point. When I compile a kernel without ACPI, the bug does not 
show its face. When I compile with ACPI in modules and load none of the 
modules, the bug still happens. I think that the bug exists in the base ACPI 
support code as a result. The bug is described below. I have not tried the 
latest linus bk patches. This current round of tests was performed on 2.5.66. 
2.5.63 is the last version of the kernel that does not have this bug.

Thanks, Warren

On Friday 28 March 2003 01:28 am, Felix Seeger wrote:
> Hi,
>
> First: I am not a developer and I don't know much about the kernel. ;)
>
> But here is a guess:
> Do you have ACPI enabled ?

> Am Friday 28 March 2003 08:04 schrieb Warren Turkal:
> > On Sunday 23 March 2003 08:36 pm, Warren Turkal wrote:
> > > I am not subscribed. Please cc on replies.
> > >
> > > I have a Gateway 600 series notebook. I have been using and testing the
> > > developmental kernel for some time now. I have just noticed that my
> > > keyboard''s "fn" key combinations stop working upon booting 2.5.65.
> > > They worked as recently as 2.5.63 and I could not get 2.5.64 to compile
> > > cleanly. These key combinations are supposed to make various things
> > > happen on my laptop. I believe that they are controlled by the bios, as
> > > I can see results of some while on the bios load screen.
> > >
> > > Fn-F1 - Labeled "Help"; don't know what it does
> > > Fn-F2 - Labeled "Status"; used to show battery status in upper left
> > > Fn-F3 - Labeled "LCD/CRT"; switch montior output among built in LCD,
> > > back monitor port, and both
> > > Fn-F4 - Labeled "Standby"; used to function as the ACPI standby button
> > > Fn-F9 - Labeled "Pad Lock"; think num lock; strangely, this one still
> > >         work in 2.5.65
> > > Fn-F10 - Labeled "Scroll Lock"
> > > Fn-F11 - Labeled "Pause"
> > > Fn-F12 - Labeled "Break"
> > >
> > > I have tested that the Fn-F2 combination works in bios and grub and
> > > continues to work until the 2.5.65 kernel is loaded.
> > >
> > > I think this is a regression in the keyboard handling for the 2.5.65
> > > kernel.
> > >
> > > Like I said before, all of the Fn combinations work in 2.5.63. If
> > > anyone has a patch from 2.5.63 to something after 2.5.64 that compiles,
> > > I would be happy to try it. I setup a bitkeeper clone of Linus's
> > > latest, so if someone could give me some bitkeeper magic to export
> > > diffs from 2.5.63 to 2.5.64 in a relavant directory (probably
> > > drivers/input/keyboard) maybe I could look to see what changed,
> > > although I don't know if I am skilled enough to find errors in the
> > > code.
> >
> > I am not subscribed. Please cc me on reply. Thanks.
> >
> > 2.5.66 still exhibits this bug. It is very strange because I even tried
> > to compile a 2.5.66 kernel without at keyboard support and it still kill
> > the Fn key functionality, meaning that I cannot make presentations on my
> > laptop because I cannot switch the video output to the back of the laptop
> > as I was able to before.
> >
> > This bug was introduced somewhere between 2.5.63 and 2.5.64. Was there
> > any work done on keyboard handling or interrupts or anything that could
> > have affected my Fn key between 2.5.63 and 2.5.64? Is there someone that
> > I should contact directly about this that is maintaining the interrupt
> > handling on X86 or whatever is causing this. I am unable to narrow down
> > the bug with the help of BK as I have not been able to find a way to find
> > and isolate the patch that caused this. Even after talking to Larry McVoy
> > about this, he suggests that I need to know what file changed and caused
> > this to narrow it down with BK. BK, apparently, can randomly change the
> > revision numbers in a way that I cannot rely on them to be constant as I
> > was under the impression in my last email. Please, someone help me. BK is
> > not easy to use for QA AFAICT.
> >
> > If anyone knows anything about this, I am begging for some help in
> > finding this bug. I have also CCed the input driver maintainer, although
> > I do not believe that this bug is in the input layer. Please CC me if you
> > reply to the list.
> >
> > Sincerely, Warren Turkal

-- 
Treasurer, GOLUM, Inc.
http://www.golum.org

