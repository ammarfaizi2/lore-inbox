Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132583AbRC2FrC>; Thu, 29 Mar 2001 00:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132584AbRC2Fqw>; Thu, 29 Mar 2001 00:46:52 -0500
Received: from kerberos.suse.cz ([195.47.106.10]:33808 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S132583AbRC2Fqg>;
	Thu, 29 Mar 2001 00:46:36 -0500
Date: Thu, 29 Mar 2001 07:45:51 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: linas@linas.org
Cc: Gunther Mayer <Gunther.Mayer@t-online.de>, linux-kernel@vger.kernel.org
Subject: Re: mouse problems in 2.4.2 -> lost byte
Message-ID: <20010329074551.A361@suse.cz>
In-Reply-To: <20010328235913.A6994@suse.cz> <20010328231933.53ECF1B7A5@backlot.linas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010328231933.53ECF1B7A5@backlot.linas.org>; from linas@linas.org on Wed, Mar 28, 2001 at 05:19:33PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2001 at 05:19:33PM -0600, linas@linas.org wrote:
> It's been rumoured that Vojtech Pavlik said:
> > On Wed, Mar 28, 2001 at 08:31:52PM +0200, Gunther Mayer wrote:
> > > linas@linas.org wrote:
> > > > It's been rumoured that Gunther Mayer said:
> > > > > linas@linas.org wrote:
> > > > > > 
> > > > > > I am experiencing debilitating intermittent mouse problems & was about
> > > > >
> > > > > This is easily explained: some byte of the mouse protocol was lost.
> > > > 
> > > Getting resync right is not as easy as detecting zero bytes. You
> > > should account for wild protocol variations in the world wide mouse
> > > population, too.
> > 
> > The new input psmouse driver can resync when bytes are lost and also
> > shouldn't lose any bytes if there are not transmission problems on the
> > wire. But this is 2.5 stuff.
> 
> umm linux kernel 2.5? Umm, given that a stable linux 2.6/3.0 might be
> years away ... and this seems 'minor', wouldn't it be better to 
> submit this as a teeny-weeny new kind of mouse device driver as a 2.4.x
> patch?  e.g. CONFIG_MOUSE_PSAUX_SUPERSYNC or something?   I mean this
> cant be more than a few hundred lines of code? Requireing no other
> changes to the kernel?

To work correctly, this requires to kill the current psaux and keyboard
driver, and those two are one file, and are very very builtin into the
console system.

Thus it's a patch of almost thousand lines to pc_keyb.c and keyboard.c
and can't easily added as a CONFIG_ option.

Plus, it's very likely the new PS/2 code will break on some systems that
have not-so-compatible i8042 chips, so it is really something that can't
go in 2.4. And I would love to have it in 2.4, really.

-- 
Vojtech Pavlik
SuSE Labs
