Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWGYKXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWGYKXn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 06:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbWGYKXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 06:23:43 -0400
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:10154 "EHLO
	mail.lidskialf.net") by vger.kernel.org with ESMTP id S1751305AbWGYKXn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 06:23:43 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Arnaud Patard <apatard@mandriva.com>
Subject: Re: Linux 2.6.17.7
Date: Tue, 25 Jul 2006 11:23:39 +0100
User-Agent: KMail/1.9.3
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org
References: <20060725034247.GA5837@kroah.com> <m33bcqdn5y.fsf@anduin.mandriva.com>
In-Reply-To: <m33bcqdn5y.fsf@anduin.mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607251123.40549.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 July 2006 10:55, Arnaud Patard wrote:
> Greg KH <gregkh@suse.de> writes:
>
> Hi,
>
> > We (the -stable team) are announcing the release of the 2.6.17.7 kernel.
>
> Sorry, but doesn't compile if DVB_BUDGET_AV is set :(
>
> > Andrew de Quincey:
> >       v4l/dvb: Fix budget-av frontend detection


In fact it is just this patch causing the problem:

> >       v4l/dvb: Fix CI on old KNC1 DVBC cards
>
> This patch is the culprit. With it, the build fails with the errors :
> drivers/media/dvb/ttpci/budget-av.c: In function 'frontend_init':
> drivers/media/dvb/ttpci/budget-av.c:1063: error: 'struct budget_av' has no
> member named 'reinitialise_demod' drivers/media/dvb/ttpci/budget-av.c:1068:
> error: request for member tuner_ops' in something not a structure or union
> drivers/media/dvb/ttpci/budget-av.c:1068: error:
> 'philips_cu1216_tuner_set_params' undeclared (first use in this function)
> drivers/media/dvb/ttpci/budget-av.c:1068: error: (Each undeclared
> identifier is reported only once drivers/media/dvb/ttpci/budget-av.c:1068:
> error: for each function it appears in.)
>
> The needed changes were introduced post 2.6.17 :
> 5c1208ba457a1668c81868060c08496a2d053be0
> 7eef5dd6daecf3ee305116c9cf41ae7166270c4c
> e87d41c4952ceef7a9f760f38f9343d015279662
>
> This would be great to see this fixed for the next -stable release :)

Sorry, I had so much work going on in that area I must have diffed the wrong 
kernel when I created this patch. :(
