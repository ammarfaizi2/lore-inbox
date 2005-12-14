Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbVLNTDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbVLNTDM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 14:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbVLNTDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 14:03:12 -0500
Received: from smtp111.sbc.mail.re2.yahoo.com ([68.142.229.94]:18363 "HELO
	smtp111.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964865AbVLNTDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 14:03:11 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH/RFC] SPI: add DMAUNSAFE analog to David Brownell's core
Date: Wed, 14 Dec 2005 11:02:52 -0800
User-Agent: KMail/1.7.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       dpervushin@gmail.com, akpm@osdl.org, basicmark@yahoo.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <20051214171842.GB30546@kroah.com> <43A05C32.3070501@ru.mvista.com>
In-Reply-To: <43A05C32.3070501@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512141102.53599.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 December 2005 9:53 am, Vitaly Wool wrote:

> 	 Sound cards behind the SPI bus will suffer a lot more 
> since it's their path to use wXrY functions (lotsa small transfers) 
> rather than WLAN's.

No, "stupid drivers will suffer"; nothing new.  Just observe
how the ads7846 touchscreen driver does small async transfers.

Remember too that sending audio data over SPI (rather than
say I2S, McBSP etc) is a different case than using it for the
mixer controls.

- Dave
