Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbUKSCUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbUKSCUH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 21:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbUKSCSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 21:18:05 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:35237 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262855AbUKRS31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:29:27 -0500
Date: Thu, 18 Nov 2004 19:29:24 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Martin Josefsson <gandalf@wlug.westbo.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: local packets not in prerouting
In-Reply-To: <1100800891.20185.59.camel@tux.rsn.bth.se>
Message-ID: <Pine.LNX.4.53.0411181928230.19795@yvahk01.tjqt.qr>
References: <Pine.LNX.4.53.0411181729350.12660@yvahk01.tjqt.qr>
 <1100800891.20185.59.camel@tux.rsn.bth.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I have been observing that locally generated packets with a local destination
>> have they don't pop up in the nat/PREROUTING chain.
>> Anybody know why this is done? (If not, it's a bug.)
>
>It's not a bug. All locally generated packets go through nat/OUTPUT ,
>not nat/PREROUTING.

Yeah I apparently found that out too now :] (it says "nat", which does not
apply to locals anyway). "mangle" looks like what I need.
Unfortunately, the REDIRECT target is only for nat, oh no :(



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
