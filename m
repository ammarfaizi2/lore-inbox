Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWJARhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWJARhW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 13:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWJARhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 13:37:22 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51117 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932110AbWJARhV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 13:37:21 -0400
Date: Sun, 1 Oct 2006 19:37:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Heikki Orsila <shd@zakalwe.fi>
Cc: "Eugeny S. Mints" <eugeny.mints@gmail.com>, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, ext-Tuukka.Tikkanen@nokia.com
Subject: Re: [linux-pm] [RFC] OMAP1 PM Core, PM Core  Implementation 2/2
Message-ID: <20061001173716.GB2253@elf.ucw.cz>
References: <20060930022435.b2344b5f.eugeny.mints@gmail.com> <20061001152228.GA24539@zakalwe.fi> <20061001171032.GE2254@elf.ucw.cz> <20061001173252.GB24539@zakalwe.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061001173252.GB24539@zakalwe.fi>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Some nitpicking about the patch follows..
> > > 
> > > On Sat, Sep 30, 2006 at 02:24:35AM +0400, Eugeny S. Mints wrote:
> > > > +static long 
> > > > +get_vtg(const char *vdomain)
> > > > +{
> > > > +	long ret = 0;
> > > 
> > > Unnecessary initialisation.
> > 
> > No, sorry.
> 
> In get_vtg(), if VOLTAGE_FRAMEWORK is defined then
> 
> 	ret = vtg_get_voltage(v);
> 
> is the first user. If VOLTAGE_FRAMEWORK is not defined, the first user is:
> 
> 	ret = vtg_get_voltage(&vhandle);
> 
> Then "return ret;" follows. I cannot see a path where 
> pre-initialisation of ret does anything useful. If someone removed the
> #else part, the compiler would bark.

Ahha, sorry, I did not look at this kind of context.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
