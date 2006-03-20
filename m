Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965062AbWCTTLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbWCTTLJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbWCTTLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:11:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:14544 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965068AbWCTTLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:11:05 -0500
X-Authenticated: #271361
Date: Mon, 20 Mar 2006 20:10:56 +0100
From: Edgar Toernig <froese@gmx.de>
To: Duncan Sands <baldrick@free.fr>
Cc: mchehab@infradead.org, linux-kernel@vger.kernel.org,
       linux-dvb-maintainer@linuxtv.org, Manu Abraham <manu@linuxtv.org>
Subject: Re: [PATCH 117/141] V4L/DVB (3390): Fix module parameters
Message-Id: <20060320201056.33b47518.froese@gmx.de>
In-Reply-To: <200603201656.16803.baldrick@free.fr>
References: <20060320150819.PS760228000000@infradead.org>
	<20060320150856.PS602870000117@infradead.org>
	<200603201656.16803.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands wrote:
>
> > -module_param(dvb_override_tune_delay, int, 0444);
> > +module_param(dvb_override_tune_delay, int, 0644);
> 
>                 if (dvb_override_tune_delay > 0)
>                         fepriv->min_delay = (dvb_override_tune_delay * HZ) / 1000;
> 
> I guess the value of dvb_override_tune_delay could change from non-zero
> to zero between testing the condition and setting min_delay.

This is within an ioctl and thus protected by the big kernel lock.

Ciao, ET.
