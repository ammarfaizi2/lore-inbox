Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVCaPRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVCaPRs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 10:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbVCaPRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 10:17:47 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:57687 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261494AbVCaPPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 10:15:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=K1eJRM7J0TqLUCwFWRLmy7fFE12kEU7ttZeFy3bsp8gE8CLhek8BwElh8NrsCQx1XizYd3Lh5gsKfp3pCxlV6ZxhQeiCPT2J8ILORzz2ZD1Cm1dQYDfJVObR8ZoyjZcIR6Oy/95aW4LXHdMvrq5fjhAeXF4EtSC04FMQsX3q42g=
Message-ID: <d120d5000503310715cbc917@mail.gmail.com>
Date: Thu, 31 Mar 2005 10:15:26 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: romano@dea.icai.upco.es, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc1 swsusp broken [Was Re: swsusp not working for me on a PREEMPT 2.6.12-rc1 and 2.6.12-rc1-mm3 kernel]
In-Reply-To: <20050331144728.GA21883@pern.dea.icai.upco.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050329110309.GA17744@pern.dea.icai.upco.es>
	 <20050329132022.GA26553@pern.dea.icai.upco.es>
	 <20050329170238.GA8077@pern.dea.icai.upco.es>
	 <20050329181551.GA8125@elf.ucw.cz>
	 <20050331144728.GA21883@pern.dea.icai.upco.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2005 16:47:29 +0200, Romano Giannetti <romanol@upco.es> wrote:
> 
> The bad news is that with 2.6.12-rc1 (no preempt) swsusp fails to go.

Ok, I see you have an ALPS touchpad. I think this patch will help you
with swsusp:

http://marc.theaimsgroup.com/?l=linux-kernel&m=111212532524998&q=raw

Also, could you please try sticking psmouse_reset(psmouse) call at the
beginning of drivers/input/mouse/alps.c::alps_reconnect() and see if
it can suspend _without_ the patch above.

Thanks!

-- 
Dmitry
