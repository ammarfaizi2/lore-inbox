Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932998AbWFZUGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932998AbWFZUGM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933003AbWFZUGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:06:11 -0400
Received: from gw.goop.org ([64.81.55.164]:24704 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932998AbWFZUGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:06:08 -0400
Message-ID: <44A03E2F.7040602@goop.org>
Date: Mon, 26 Jun 2006 13:06:07 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Matt Domsch <Matt_Domsch@dell.com>, Andrew Morton <akpm@osdl.org>,
       Corey Minyard <minyard@acm.org>, linux-kernel@vger.kernel.org,
       peter@palfrader.org, openipmi-developer@lists.sourceforge.net
Subject: Re: [PATCH] IPMI: use schedule in kthread
References: <20060626140819.GA17804@localdomain>	 <20060626120048.cff87fac.akpm@osdl.org>	 <20060626194937.GA16528@lists.us.dell.com> <1151351921.3185.76.camel@laptopd505.fenrus.org>
In-Reply-To: <1151351921.3185.76.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> at least put a whole bunch of cpu_relax() in that loop, or your cpu
> will.. get hot. Would also be nice if cpufreq had a "run this one slow"
> option.... 
The "conservative" and "ondemand" governors have an "ignore niced 
processes" setting, which looks like it would help here.

    J
