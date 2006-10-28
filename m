Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWJ1VFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWJ1VFa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 17:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWJ1VFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 17:05:30 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59030 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964826AbWJ1VFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 17:05:30 -0400
Date: Sat, 28 Oct 2006 23:05:09 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Zeuthen <davidz@redhat.com>
Cc: Richard Hughes <hughsient@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Shem Multinymous <multinymous@gmail.com>,
       Dan Williams <dcbw@redhat.com>, linux-kernel@vger.kernel.org,
       devel@laptop.org, sfr@canb.auug.org.au, len.brown@intel.com,
       greg@kroah.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>
Subject: Re: [PATCH v2] Re: Battery class driver.
Message-ID: <20061028210509.GA30819@elf.ucw.cz>
References: <41840b750610250254x78b8da17t63ee69d5c1cf70ce@mail.gmail.com> <1161778296.27622.85.camel@shinybook.infradead.org> <41840b750610250742p7ad24af9va374d9fa4800708a@mail.gmail.com> <1161815138.27622.139.camel@shinybook.infradead.org> <41840b750610251639t637cd590w1605d5fc8e10cd4d@mail.gmail.com> <1162037754.19446.502.camel@pmac.infradead.org> <1162041726.16799.1.camel@hughsie-laptop> <1162048148.2723.61.camel@zelda.fubar.dk> <20061028185513.GD5152@ucw.cz> <1162065236.2723.83.camel@zelda.fubar.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162065236.2723.83.camel@zelda.fubar.dk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2006-10-28 15:53:56, David Zeuthen wrote:
> On Sat, 2006-10-28 at 18:55 +0000, Pavel Machek wrote:
> > Bad idea... I bet someone will just ignore the units part, because all
> > the machines he seen had mW there. 
> 
> Sure, user space can do silly things. Just ask davej. Let's try to
> assume they don't.
> 
> > Just put it into the name:
> > 
> > power_avg_mV
> 
> Bad idea... it means user space will have to try to open different files
> and what happens when someone introduces a new unit? Ideally I'd like
> the unit to be part of the payload of the sysfs file. Second to that I
> think having the unit in a separate file is preferable.

Introducing new unit *should* be hard. You know, when you introduce
new unit, you automatically break all the userspace.

Having separate files is actually a *feature*. It allows you to
introduce new units while providing backwards compatibility.

Imagine going from mV to uV... With voltage_mV, you can have both
voltage_mV and voltage_uV. In your system, you'd have to change value
from mV to uV, breaking all the userspace....
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
