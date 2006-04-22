Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWDVRwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWDVRwv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 13:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbWDVRwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 13:52:49 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:54429 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750852AbWDVRwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 13:52:11 -0400
X-ME-UUID: 20060422084648367.59BDD7000085@mwinf1306.wanadoo.fr
Date: Sat, 22 Apr 2006 10:45:45 +0200
From: Mathieu Chouquet-Stringer <mchouque@free.fr>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Bob Tracy <rct@gherkin.frus.com>, linux-kernel@vger.kernel.org,
       linux-alpha@vger.kernel.org, rth@twiddle.net
Subject: Re: strncpy (maybe others) broken on Alpha
Message-ID: <20060422084545.GA8079@bigip.bigip.mine.nu>
Mail-Followup-To: Mathieu Chouquet-Stringer <mchouque@free.fr>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Bob Tracy <rct@gherkin.frus.com>, linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org, rth@twiddle.net
References: <20060421095028.GA8818@bigip.bigip.mine.nu> <20060421114149.24F5EDBA1@gherkin.frus.com> <20060421115556.GA14178@bigip.bigip.mine.nu> <20060421182223.C19738@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421182223.C19738@jurassic.park.msu.ru>
User-Agent: Mutt/1.4.2.1i
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 06:22:23PM +0400, Ivan Kokshaysky wrote:
> Oops. I was using a wrong copy of strncpy.S (remained from previous
> __stxncpy() debugging). What's why I wasn't able to reproduce that...
> 
> It seems that the registers $24 and $27 are mixed up in strncpy().
> This fixes your test case, please check if it fixes kernel problem
> as well.

Well done, it indeed fixed the test case.  I'll try the kernel when I
get back home...

While we're at it, next week, I'll exercise the other functions to make
sure they also work as they should.

Thanks Ivan and Bob for your time, valuable feedback and work!!!
-- 
Mathieu Chouquet-Stringer                           mchouque@free.fr

