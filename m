Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161065AbVKDFNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161065AbVKDFNI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 00:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161066AbVKDFNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 00:13:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7854 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161065AbVKDFNH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 00:13:07 -0500
Date: Thu, 3 Nov 2005 21:12:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mike Krufky <mkrufky@linuxtv.org>
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       kirk.lapray@gmail.com
Subject: Re: [PATCH 30/37] dvb: add nxt200x frontend module
Message-Id: <20051103211254.607a5d32.akpm@osdl.org>
In-Reply-To: <436A959D.8090403@linuxtv.org>
References: <43672436.6000006@m1k.net>
	<20051103141125.1463c1bd.akpm@osdl.org>
	<436A959D.8090403@linuxtv.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Krufky <mkrufky@linuxtv.org> wrote:
>
> Andrew Morton wrote:
> 
> >Michael Krufky <mkrufky@m1k.net> wrote:
> >
> >>+
> >>+static int nxt200x_writetuner (struct nxt200x_state* state, u8* data)
> >>+{
> >>+	u8 buf, count = 0;
> >>+
> >>+	dprintk("%s\n", __FUNCTION__);
> >>+
> >>+	dprintk("Tuner Bytes: %02X %02X %02X %02X\n", data[0], data[1], data[2], data[3]);
> >>+
> >>+	/* if pll is a Philips TUV1236D then write directly to tuner */
> >>+	if (strcmp(state->config->pll_desc->name, "Philips TUV1236D") == 0) {
> >>    
> >>
> >Does DVB have a better way of identifying a device type than strcmp?
> >  
> >
> I said the same thing when I first saw this, but I wanted to send the 
> patches separately, because Kirk wrote the driver, and I corrected the 
> above issue in a separate patch:
> 
> dvb-determine-tuner-write-method-based-on-nxt-chip.patch
> 
> Feel free to fold them if you like... I was only trying to indicate separate authorship.

OK.

> As for the other comments for the rest of the patch series, some of the fixes are trivial.  Should I expect that you will correct these?  or do you need me to send you more patches?

I got lazy and didn't alter the patches in any way.  Mostly this was a
"please do it this way in the future" exercise.

> For now, I think the corrections should wait for Johannes' return, 
> unless you want to take care of them.  I think he comes back JUST after 
> the end of the merge window... not quite sure.

At your convenience.

> I have 3 or 4 more patches coming.... I plan to send before the end of 
> tonight.

Oh good.  More patches ;)
