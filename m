Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbUDFPd1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 11:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUDFPdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 11:33:14 -0400
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:60071 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S263868AbUDFPb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 11:31:28 -0400
Message-ID: <4072CD22.4010603@backtobasicsmgmt.com>
Date: Tue, 06 Apr 2004 08:30:42 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back To Basics Network Management
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Xavier Bestel <xavier.bestel@free.fr>
CC: Andi Kleen <ak@muc.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
       linux-kernel@vger.kernel.org
Subject: Re: {put,get}_user() side effects
References: <1HVGV-1Wl-21@gated-at.bofh.it>	 <m3fzbhfijh.fsf@averell.firstfloor.org> <1081261716.8318.7.camel@speedy.priv.grenoble.com>
In-Reply-To: <1081261716.8318.7.camel@speedy.priv.grenoble.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel wrote:

> Sorry, I read too fast. I didn't know sizeof could avoid side effects.
> 

Both typeof and sizeof are compile-time constructs, so there is no 
opportunity for any expression side effects to occur. Presumably one 
could do:

typeof(1/0UL)

without ever causing the obvious side effect either (granted, this is a 
pointless piece of code :-)).
