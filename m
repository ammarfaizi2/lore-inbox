Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270457AbUJUG0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270457AbUJUG0T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 02:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268950AbUJUGWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 02:22:06 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:5760 "EHLO midnight.suse.cz")
	by vger.kernel.org with ESMTP id S270437AbUJUGV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 02:21:26 -0400
Date: Thu, 21 Oct 2004 08:21:03 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, Dmitry Torokhov <dtor_core@ameritech.net>,
       Alexandre Oliva <aoliva@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: forcing PS/2 USB emulation off
Message-ID: <20041021062103.GA1252@ucw.cz>
References: <orzn2lyw8k.fsf@livre.redhat.lsd.ic.unicamp.br> <200410172248.16571.dtor_core@ameritech.net> <20041018164539.GC18169@kroah.com> <20041019063057.GA3057@ucw.cz> <1098302200.12374.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098302200.12374.44.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 08:56:43PM +0100, Alan Cox wrote:

> On Maw, 2004-10-19 at 07:30, Vojtech Pavlik wrote:
> > Like 30% of all notebooks? ;) They do boot without the USB handoff, the
> > PS/2 mouse works, but only as a PS/2 mouse, no extended capabilities
> > detection is possible due to the BIOS interference.
> 
> I started in favour of avoiding always doing the handoff, but now I'm
> convinced handoff should be the default. 

And I would be fine to move the atkbd/psmouse initialization down in the
Makefiles so that USB gets initialized first - but what do we do about
the modular case? 

I do agree that we should have only one copy of the handoff code,
regardless of where it's living.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
