Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbUFXIhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUFXIhO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 04:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbUFXIhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 04:37:14 -0400
Received: from main.gmane.org ([80.91.224.249]:37608 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261439AbUFXIhL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 04:37:11 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
Subject: Re: linux 2.4.25, Promise 20269, DMA/IRQ problems ?
Date: Thu, 24 Jun 2004 10:37:06 +0200
Organization: Technische Universitaet Ilmenau, Germany
Message-ID: <cbe3ri$kf2$1@sea.gmane.org>
References: <87brjaxrto.fsf@deirdre.ambre.meuh.eu.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd9e23dc3.dip.t-dialin.net
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yann Droneaud <yann@droneaud.com> wrote:
> SMART and smartmontools were enabled until 21 june, I disabled them
> since there are some warning about SMART and Promise card:
> http://cvs.sourceforge.net/viewcvs.py/smartmontools/sm5/WARNINGS?sortby=date&view=markup
> but it doesn't solve the problem.
>
> The problems seems to occurs now with regularity each morning during
> the cron.daily work (Debian GNU/Linux woody), so it's probably a drive problem,

Well, this looks exactly like my 'signalling/power' issue.
Have a look at my last mail to the 'Strange DMA-errors and
system hang with Promise 20268' thread on the lkm which is
also mentioned on the page you already found.

The role smartmontools plays in this game is the same that
your cronjobs do: they put load on the devices - parallel
load on all of them and thus power consumption increases
and if the power supply works on it's upper border, on-the-
wire signal quality probably decreases.

I pointed this out in a thread 'Logs - ideas what this is
reporting' on the smartmontools-support list too.

Try to exchange power supply, IDE cables and perhaps clean
PCI slots :)
This could be a bit tricky without physical control to the
machine, but you surely will have someone who has :)
Of course, this is just a try - however, I'd bet it helps
in your case.



regards,
   Mario
-- 
I heard, if you play a NT-CD backwards, you get satanic messages...
That's nothing. If you play it forwards, it installs NT.

