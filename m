Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWJDV0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWJDV0M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWJDV0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:26:12 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18320 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751142AbWJDVZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:25:52 -0400
Date: Wed, 4 Oct 2006 23:25:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Scott E. Preece" <preece@motorola.com>
Cc: shd@zakalwe.fi, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org,
       ext-Tuukka.Tikkanen@nokia.com
Subject: Re: [linux-pm] [RFC] OMAP1 PM Core, PM Core  Implementation 2/2
Message-ID: <20061004212545.GD8437@elf.ucw.cz>
References: <200610021919.k92JJMs1011215@olwen.urbana.css.mot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610021919.k92JJMs1011215@olwen.urbana.css.mot.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> | > > > +static long 
> | > > > +get_vtg(const char *vdomain)
> | > > > +{
> | > > > +	long ret = 0;
> | > > 
> | > > Unnecessary initialisation.
> | > 
> | > No, sorry.
> | 
> | In get_vtg(), if VOLTAGE_FRAMEWORK is defined then
> | 
> | 	ret = vtg_get_voltage(v);
> | 
> | is the first user. If VOLTAGE_FRAMEWORK is not defined, the first user is:
> | 
> | 	ret = vtg_get_voltage(&vhandle);
> | 
> | Then "return ret;" follows. I cannot see a path where 
> | pre-initialisation of ret does anything useful. If someone removed the
> | #else part, the compiler would bark.
> ---
> 
> True, but a good compiler should remove the dead initialization...

True, but efficient code is only one of constraints. Code should be
easy to read, too.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
