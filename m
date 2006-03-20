Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965612AbWCTP4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965612AbWCTP4k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965608AbWCTP4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:56:39 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:12424 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S965058AbWCTP4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:56:21 -0500
From: Duncan Sands <baldrick@free.fr>
To: mchehab@infradead.org
Subject: Re: [PATCH 117/141] V4L/DVB (3390): Fix module parameters
Date: Mon, 20 Mar 2006 16:56:16 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       Manu Abraham <manu@linuxtv.org>
References: <20060320150819.PS760228000000@infradead.org> <20060320150856.PS602870000117@infradead.org>
In-Reply-To: <20060320150856.PS602870000117@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603201656.16803.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -module_param(dvb_override_tune_delay, int, 0444);
> +module_param(dvb_override_tune_delay, int, 0644);

                if (dvb_override_tune_delay > 0)
                        fepriv->min_delay = (dvb_override_tune_delay * HZ) / 1000;

I guess the value of dvb_override_tune_delay could change from non-zero
to zero between testing the condition and setting min_delay.  Probably
this doesn't matter, but still...

Ciao,

D.
