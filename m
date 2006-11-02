Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWKBWCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWKBWCI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 17:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbWKBWCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 17:02:08 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1991 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750890AbWKBWCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 17:02:04 -0500
Date: Thu, 2 Nov 2006 23:01:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Greg KH <greg@kroah.com>, Shem Multinymous <multinymous@gmail.com>,
       David Zeuthen <davidz@redhat.com>, Richard Hughes <hughsient@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>,
       Jean Delvare <khali@linux-fr.org>
Subject: Re: [ltp] Re: [PATCH v2] Re: Battery class driver.
Message-ID: <20061102220145.GB2192@elf.ucw.cz>
References: <1162037754.19446.502.camel@pmac.infradead.org> <1162041726.16799.1.camel@hughsie-laptop> <1162048148.2723.61.camel@zelda.fubar.dk> <41840b750610281112q7790ecao774b3d1b375aca9b@mail.gmail.com> <20061031074946.GA7906@kroah.com> <41840b750610310528p4b60d076v89fc7611a0943433@mail.gmail.com> <20061101193134.GB29929@kroah.com> <41840b750611011153w3a2ace72tcdb45a446e8298@mail.gmail.com> <20061101205330.GA2593@kroah.com> <20061101235540.GA11581@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101235540.GA11581@khazad-dum.debian.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Well, "Wh" measures energy and not power, and "Ah" measures electric charge
> and not current, so it would be better to make that:
> 
> capacity_*_energy  (Wh-based)
> 
> and
> 
> capacity_*_charge  (Ah-based)
> 
> Also, should we go with mWh/mAh, or with even smaller units because of the
> tiny battery-driven devices of tomorrow?

Okay... So I have cellphone here, 700mAh battery, ~2.8Wh battery. It
could last 14 days if we were *very* careful. 

echo '(700 mA * hour) / (14*day) \ A' | ucalc

ucalc> OK:  0.002083
ucalc>

...that is about 2mA in low power standby mode (but still listening on
GSM, getting calls, etc).

...so, mAh are probably good enough for capacity_*_charge, but would
suck for current power consumption, as difference between 2mA and 3mA
would be way too big. We need some finer unit in that case.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
