Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVCaQw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVCaQw6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 11:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVCaQw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 11:52:58 -0500
Received: from upco.es ([130.206.70.227]:58831 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S261573AbVCaQuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 11:50:10 -0500
Date: Thu, 31 Mar 2005 18:50:07 +0200
From: Romano Giannetti <romanol@upco.es>
To: dtor_core@ameritech.net
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc1 swsusp broken [Was Re: swsusp not working for me on a PREEMPT 2.6.12-rc1 and 2.6.12-rc1-mm3 kernel]
Message-ID: <20050331165007.GA29674@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: romano@dea.icai.upco.es, dtor_core@ameritech.net,
	Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <20050329110309.GA17744@pern.dea.icai.upco.es> <20050329132022.GA26553@pern.dea.icai.upco.es> <20050329170238.GA8077@pern.dea.icai.upco.es> <20050329181551.GA8125@elf.ucw.cz> <20050331144728.GA21883@pern.dea.icai.upco.es> <d120d5000503310715cbc917@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <d120d5000503310715cbc917@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2005 at 10:15:26AM -0500, Dmitry Torokhov wrote:
> On Thu, 31 Mar 2005 16:47:29 +0200, Romano Giannetti <romanol@upco.es> wrote:
> > 
> > The bad news is that with 2.6.12-rc1 (no preempt) swsusp fails to go.
> 
> Ok, I see you have an ALPS touchpad. I think this patch will help you
> with swsusp:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111212532524998&q=raw

Yes! With this it works ok.

> Also, could you please try sticking psmouse_reset(psmouse) call at the
> beginning of drivers/input/mouse/alps.c::alps_reconnect() and see if
> it can suspend _without_ the patch above.

It works, too. Which one is the best one? 

I will try now with preempt, although I suspect that this was an unrelated
problem.

Thanks a lot,
         Romano
-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
