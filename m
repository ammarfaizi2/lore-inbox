Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266460AbUJIBES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266460AbUJIBES (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 21:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266463AbUJIBER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 21:04:17 -0400
Received: from gate.crashing.org ([63.228.1.57]:33709 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266460AbUJIBEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 21:04:06 -0400
Subject: Re: hang after resume with adb: starting probe task.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1097234268.3339.27.camel@localhost>
References: <1097172895.3281.31.camel@localhost>
	 <1097189899.16161.6.camel@gaston>  <1097234268.3339.27.camel@localhost>
Content-Type: text/plain
Message-Id: <1097283818.3646.7.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 09 Oct 2004 11:03:38 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Actually there was nothing plugged into the ethernet nor usb port. Could
> it also be the airport failing ? I still use orinoco cvs, i.e. airport
> 0.15rc2HEAD, but that one also on 2.6.8.1. 
> 
> I now have a more or less reliable way of making this pbook crash: put
> it to sleep and wake it up as soon it is sleeping.

Difficult to say at this point. One thing possible is to add printk's
(or more violent btext_drawstring) when calling the sleep / wakeup
callbacks of drivers in drivers/base/power/* and drivers/macintosh/via-pmu.c
and try to figure where precisely it dies.

Ben.


