Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270227AbTHLLgI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 07:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270291AbTHLLgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 07:36:08 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:30122
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S270227AbTHLLf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 07:35:58 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [Bug 1068] New: Errors when loading airo module
Date: Tue, 12 Aug 2003 07:38:00 -0400
User-Agent: KMail/1.5
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, kernelbugzilla@kuntnet.org
References: <51060000.1060524422@[10.10.2.4]> <200308120447.00105.rob@landley.net> <20030812123214.B10895@flint.arm.linux.org.uk>
In-Reply-To: <20030812123214.B10895@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308120738.00641.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 August 2003 07:32, Russell King wrote:
> On Tue, Aug 12, 2003 at 04:46:56AM -0400, Rob Landley wrote:
> > On Sunday 10 August 2003 11:33, Russell King wrote:
> > > On Sun, Aug 10, 2003 at 07:07:02AM -0700, Martin J. Bligh wrote:
> > > > http://bugme.osdl.org/show_bug.cgi?id=1068
> > > >
> > > >            Summary: Errors when loading airo module
> > > >     Kernel Version: 2.6.0-test3
> > > >             Status: NEW
> > > >           Severity: normal
> > > >              Owner: rmk@arm.linux.org.uk
> > > >          Submitter: kernelbugzilla@kuntnet.org
> > >
> > > This needs to go to the airo maintainers, not me - the oops is caused
> > > by buggy airo.c.
> > >
> > > The IRQ problem is the result of bad configuration - you must enable
> > > CONFIG_ISA if you're going to use non-Cardbus PCMCIA cards.
> >
> > Do you mean something like:
>
> No.  Its legal to enable PCMCIA without ISA.
>
> The patch below is wrong in any case - the SA11xx stuff should not depend
> on ISA.

Okay, so which non-Cardbus PCMCIA slections, which are not legal to enable 
without CONFIG_ISA, are missing a kconfig dependency on CONFIG_ISA?  (I 
guessed it was the ARM specific ones, but it was just a guess...)

Or are you suggesting they didn't run make oldconfig?

Rob
