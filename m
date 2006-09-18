Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751629AbWIRNqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbWIRNqw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 09:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbWIRNqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 09:46:52 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31197 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751624AbWIRNqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 09:46:52 -0400
Date: Mon, 18 Sep 2006 15:46:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Scott E. Preece" <preece@motorola.com>
Cc: daviado@gmail.com, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] OpPoint summary
Message-ID: <20060918134646.GF5370@elf.ucw.cz>
References: <200609181336.k8IDa7xp025747@olwen.urbana.css.mot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609181336.k8IDa7xp025747@olwen.urbana.css.mot.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H!

> | > +static struct oppoint lowest = {
> | > +       .name = "lowest",
> | > +       .type = PM_FREQ_CHANGE,
> | > +       .frequency = 0,
> | > +       .voltage = 0,
> | > +       .latency = 15,
> | > +       .prepare_transition  = cpufreq_prepare_transition,
> | > +       .transition = centrino_transition,
> | > +       .finish_transition = cpufreq_finish_transition,
> | > +};
> | 
> | We had nice, descriptive interface... with numbers. Now you want to
> | introduce english state names... looks like a step back to me.
> ---
> 
> Well, a single number is fine if you're describing a scalar abstraction,
> but an operating point is a vector. You can't assume that "399" is three
> times "133" in performance or energy cost, so its "numberness" is simply
> misleading.

"lowest" can simply be mapped to "0", with "low" mapped to "1",
etc.

I believe, using english names is wrong in this case. If you want to
provide vectors... well provide the vectors. Is "medium" operating
point 1GHz on cpu 0 and 2GHz on cpu 1, or is it 1.5 ghz on cpu 0 and
1.5 ghz on cpu 1?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
