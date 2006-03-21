Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965042AbWCULTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbWCULTE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbWCULTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:19:03 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:46759 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S965042AbWCULTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:19:01 -0500
From: Duncan Sands <baldrick@free.fr>
To: Edgar Toernig <froese@gmx.de>
Subject: Re: [PATCH 117/141] V4L/DVB (3390): Fix module parameters
Date: Tue, 21 Mar 2006 12:18:56 +0100
User-Agent: KMail/1.9.1
Cc: mchehab@infradead.org, linux-kernel@vger.kernel.org,
       linux-dvb-maintainer@linuxtv.org, Manu Abraham <manu@linuxtv.org>
References: <20060320150819.PS760228000000@infradead.org> <200603201656.16803.baldrick@free.fr> <20060320201056.33b47518.froese@gmx.de>
In-Reply-To: <20060320201056.33b47518.froese@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603211218.57621.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > -module_param(dvb_override_tune_delay, int, 0444);
> > > +module_param(dvb_override_tune_delay, int, 0644);
> > 
> >                 if (dvb_override_tune_delay > 0)
> >                         fepriv->min_delay = (dvb_override_tune_delay * HZ) / 1000;
> > 
> > I guess the value of dvb_override_tune_delay could change from non-zero
> > to zero between testing the condition and setting min_delay.
> 
> This is within an ioctl and thus protected by the big kernel lock.

You are right.

Best wishes,

Duncan.
