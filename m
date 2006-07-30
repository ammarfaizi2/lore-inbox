Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWG3VVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWG3VVc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 17:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWG3VVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 17:21:32 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27091 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932311AbWG3VVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 17:21:32 -0400
Subject: Re: REGRESSION: the new i386 timer code fails to sync CPUs
From: Arjan van de Ven <arjan@infradead.org>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, bunk@stusta.de, lethal@linux-sh.org,
       hirofumi@mail.parknet.co.jp, asit.k.mallick@intel.com
In-Reply-To: <20060730211359.GZ3662@kiste.smurf.noris.de>
References: <20060723081604.GD27566@kiste.smurf.noris.de>
	 <20060723044637.3857d428.akpm@osdl.org>
	 <20060723120829.GA7776@kiste.smurf.noris.de>
	 <20060723053755.0aaf9ce0.akpm@osdl.org>
	 <1153756738.9440.14.camel@localhost>
	 <20060724171711.GA3662@kiste.smurf.noris.de>
	 <20060724175150.GD50320@muc.de> <1153774443.12836.6.camel@localhost>
	 <20060730020346.5d301bb5.akpm@osdl.org> <20060730201005.GA85093@muc.de>
	 <20060730211359.GZ3662@kiste.smurf.noris.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 30 Jul 2006 23:20:44 +0200
Message-Id: <1154294444.2941.50.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-30 at 23:13 +0200, Matthias Urlichs wrote:
> Hi,
> 
> Andi Kleen:
> > > It is a "CPU0: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03".
> > 
> > Was that on that system? I guess it could be checked for and TSC 
> > be forced off. It sounds like a real CPU bug however.
> > 
> Board problem? After all, it has some very noxious DMI entries:
> 
> System Information
>         Manufacturer: Intel Corporation
>         Product Name: Nocona/Tumwater Customer Reference Board
>         Version: Revision A0
>         Serial Number: 0123456789
>         UUID: 0A0A0A0A-0A0A-0A0A-0A0A-0A0A0A0A0A0A
> 
> ... all of which are patently *wrong*.
> 
> You'd have to ask the people from Tyan what the hell they were smoking
> when they blindly copied the Intel data.
> 
> At least the different CPU speed issue is a known bug, fixed by a
> BIOS update. I'll postpone that until we have a working kernel fix,
> for obvious reasons.

if the hardware side is different *speed*.. then a tsc sync ain't going
to work... sure we write to it but it's immediately out of sync again


> 
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

