Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752214AbWJ1MQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214AbWJ1MQD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 08:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752210AbWJ1MQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 08:16:02 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46525 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752204AbWJ1MQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 08:16:00 -0400
Subject: Re: [PATCH v2] Re: Battery class driver.
From: David Woodhouse <dwmw2@infradead.org>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Richard Hughes <hughsient@gmail.com>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, greg@kroah.com, benh@kernel.crashing.org,
       David Zeuthen <davidz@redhat.com>,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>
In-Reply-To: <41840b750610251639t637cd590w1605d5fc8e10cd4d@mail.gmail.com>
References: <1161628327.19446.391.camel@pmac.infradead.org>
	 <1161631091.16366.0.camel@localhost.localdomain>
	 <1161633509.4994.16.camel@hughsie-laptop>
	 <1161636514.27622.30.camel@shinybook.infradead.org>
	 <1161710328.17816.10.camel@hughsie-laptop>
	 <1161762158.27622.72.camel@shinybook.infradead.org>
	 <41840b750610250254x78b8da17t63ee69d5c1cf70ce@mail.gmail.com>
	 <1161778296.27622.85.camel@shinybook.infradead.org>
	 <41840b750610250742p7ad24af9va374d9fa4800708a@mail.gmail.com>
	 <1161815138.27622.139.camel@shinybook.infradead.org>
	 <41840b750610251639t637cd590w1605d5fc8e10cd4d@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 28 Oct 2006 13:15:54 +0100
Message-Id: <1162037754.19446.502.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-26 at 01:39 +0200, Shem Multinymous wrote:
> > They're simple enough to add. We can do it when the tp driver gets
> > converted over.
> 
> Sure. But It will require some thought. For example, the interface
> will need to encompass the non-symmetric pair of force commands on
> ThinkPads:
> "discharge the battery until further notice" vs.
> "don't charge the battery for N minutes".
> 
> Also, ThinkPads express  the start/stop charging thresholds in
> percent, whereas I imagine some other hardware will represent it as
> capacity.

Hm. Again we have the question of whether to export 'threshold_pct' vs.
'threshold_abs', or whether to have a separate string property which
says what the 'unit' of the threshold is. I don't care much -- I'll do
whatever DavidZ prefers.

The git tree now has support for battery information available from the
PMU on Apple laptops. I _really_ don't like the way I have to register a
fake platform_device just to be able to get sensible attribute
callbacks. I suspect it should go back to being a class_device and we
should fix the class_device attribute functions. Greg?

-- 
dwmw2

