Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265815AbUBBXTJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 18:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265846AbUBBXTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 18:19:08 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:32386 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S265815AbUBBXTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 18:19:06 -0500
Date: Tue, 3 Feb 2004 00:19:02 +0100
To: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Cc: Frank Otto <Frank.Otto@tc.pci.uni-heidelberg.de>
Subject: Re: 2.6.1 Speaker
Message-ID: <20040202231902.GA25385@fubini.pci.uni-heidelberg.de>
References: <20040131022540.04278a4a.backblue@netcabo.pt> <20040131081439.GA440@ucw.cz> <20040201013136.GA16043@fubini.pci.uni-heidelberg.de> <20040201082143.GB287@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040201082143.GB287@ucw.cz>
User-Agent: Mutt/1.3.28i
From: Bernd Schubert <Bernd.Schubert@tc.pci.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 01, 2004 at 09:21:43AM +0100, Vojtech Pavlik wrote:
> On Sun, Feb 01, 2004 at 02:31:36AM +0100, Bernd Schubert wrote:
> 
> > On Sat, Jan 31, 2004 at 09:14:39AM +0100, Vojtech Pavlik wrote:
> > > On Sat, Jan 31, 2004 at 02:25:40AM +0000, backblue wrote:
> > > 
> > > > I'm using 2.6.1 kernel, and my speakers stop's working with 2.6.1,
> > > > anyone know why? this dont append to me, a couple of friends have the
> > > > same problem, how can i solve this... 
> > > 
> > > You need to enable it. Drivers->Input->Misc->PC-Speaker
> > >
> > 
> > I was wondering myself why I didn't get any speaker-output, so this is
> > the solution. However, I'm wondering why this is a sub-option of Input
> > and not of Sound?
> 
> Because it's an device that registers with the input (console)
> subsystem, and not with the sound (alsa/oss) subsystem. It's a beeper,
> not a sound card.
>

Well, I was discussing it today with a colleague and I think his arguments 
are convincing (citation from memory):
"From the point of a kernel developer and kernel internal programming 
it might be better to put it under Input, but the kernel configuration 
interface is written mostly for end-users who might/will not know about 
kernel internals, so most people will expect this option under Sound."

Would it be so bad to put it to Drivers->Sound->Misc->PC-Speaker?

Thanks,
	Bernd
