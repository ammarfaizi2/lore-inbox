Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbUD1VNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbUD1VNI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 17:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbUD1VKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 17:10:44 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:46046 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262176AbUD1U7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 16:59:41 -0400
Date: Wed, 28 Apr 2004 13:59:38 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: Ross Dickson <ross@datscreative.com.au>
Cc: Len Brown <len.brown@intel.com>, a.verweij@student.tudelft.nl,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Craig Bradney <cbradney@zip.com.au>, christian.kroener@tu-harburg.de,
       linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, Allen Martin <AMartin@nvidia.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH] for idle=C1halt, 2.6.5
Message-ID: <20040428205938.GA1995@tesore.local>
Mail-Followup-To: Jesse Allen <the3dfxdude@hotmail.com>,
	Ross Dickson <ross@datscreative.com.au>,
	Len Brown <len.brown@intel.com>, a.verweij@student.tudelft.nl,
	"Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
	Craig Bradney <cbradney@zip.com.au>,
	christian.kroener@tu-harburg.de, linux-kernel@vger.kernel.org,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Jamie Lokier <jamie@shareable.org>,
	Daniel Drake <dan@reactivated.net>, Ian Kumlien <pomac@vapor.com>,
	Allen Martin <AMartin@nvidia.com>
References: <Pine.GHP.4.44.0404271807470.6154-100000@elektron.its.tudelft.nl> <1083088854.2322.38.camel@dhcppc4> <200404282133.34887.ross@datscreative.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404282133.34887.ross@datscreative.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 09:33:34PM +1000, Ross Dickson wrote:
> > 
> > It may be this board never hangs no matter what,
> > or perhaps C1 disconnect was simply disabled in that BIOS
> > b/c there was no option for it in Advanced Chipset Features
> > like there is for the most recent BIOS.
> 
> Maybe other MOBO manufacturers skimp on filter caps and regulator damping
> ability and a resonance occurs in the on-board supply rails? Do Shuttle make
> any claims to using an improved on board regulator? Or Shuttle may have 
> always programmed more time in C1 cycle handshakes if such is 
> configurable? 

Do you really think so?  I think there may be a resonance occuring, even with 
this new BIOS.  I plugged in new headphones into my nforce2 onboard sound, and 
get a high pitched noise.  Now here is where it gets weird:  This noise does 
not occur on boot until sometime after the IDE driver is loaded.  I also 
believe it varies under a high load.  If you disable C1 disconnect, it's gone.  
Also I've heard a high pitched noise at certain times coming right from the 
copmuter (very faint, but I do have very good hearing, I can even hear a hush 
sounding from my router.  my brother was quite astonished when I pointed that 
out)  I try to distinguish whats doing it.  It could be the hard drive.  But 
when I found the other sound in the head phones, I found that the sound varies 
almost in unison with the sound coming from the computer.  Maybe the IDE or 
hard drive is related, but it is too much related to C1 disconnect.

Whether it is really possible that my board can really generate this sound, I 
don't know.  Though, I have once determined that resonance was occuring in an 
old system, causing unstable CPU operation.  It wasn't that I heard a sound 
coming from it =).  But what I thought was the case was causing it, and pulled 
it out of the case.  I ran it on the table and found it to be stable.  That 
was the only thing wrong.  I've also studied resonance before a bit.  I know 
resonance can break systems.  But to think that my board is doing emmitting 
noise like that is pretty bizarre. 

It may be true that this Shuttle board may have resonance problems.  So that 
would indicate that they did something much like you describe by changing the 
C1 handshake time?  Isn't that much like what your patch does?


> 
> > hang issue is completely explained and solved.
> 
> I have had good (100%) success in reproducing the fault with the Albatron 
> KM18G pro MOBO. I needed m-atx form factor and distributor was local to me.
> Makes very nice - cheap and stable system but only with the lockup workaround.
> 
> I also recollect that Windows had lockups with nforce2 for a while depending 
> whether you ran the Nvidia or Microsoft driver.
> http://lkml.org/lkml/2003/12/13/5
> Anybody got the inside running on that one and what was different between the 
> two drivers?
> 

Yeah, unfortunately, I didn't save a link to the message board that I found 
that on.  But the issue is pretty common.  I'm sure more info can be found on i
the windows side.

Jesse

