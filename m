Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWBEN3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWBEN3Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 08:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWBEN3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 08:29:25 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:40397 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S1750801AbWBEN3Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 08:29:24 -0500
Date: Sun, 5 Feb 2006 14:29:30 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Michael Krufky <mkrufky@linuxtv.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Message-ID: <20060205132930.GA6221@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Michael Krufky <mkrufky@linuxtv.org>, Adrian Bunk <bunk@stusta.de>,
	linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
References: <20060204233751.GH4528@stusta.de> <43E5A23D.8080107@linuxtv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E5A23D.8080107@linuxtv.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: 84.189.221.204
Subject: Re: [v4l-dvb-maintainer] [2.6 patch]	drivers/media/dvb/frontends/mt312.c: possible cleanups
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2006, Michael Krufky wrote:
> Adrian Bunk wrote:
> >+	if (state->id == ID_VP310){

lacks a space

> >-EXPORT_SYMBOL(mt312_attach);
> >-EXPORT_SYMBOL(vp310_attach);
> >+EXPORT_SYMBOL(vp310_mt312_attach);
> 
> ^^^ I think vp310_mt312_attach is starting to get long, maybe even ugly. 
>  Isn't mt312_attach enough, considering that it is the name of the 
> module?  I think just mt312_attach would be nicer, unless someone thinks 
> otherwise?
...
> >-	if ((fc->fe = vp310_attach(&skystar23_samsung_tbdu18132_config, 
> >&fc->i2c_adap)) != NULL) {
> >+	if ((fc->fe = 
> >vp310_mt312_attach(&skystar23_samsung_tbdu18132_config, &fc->i2c_adap)) != 
> >NULL) {

mt312_attach() isn't used by any driver, so it looks like a bad choice
for a name. IMHO vp310_mt312_attach() is fine.


Johannes
