Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269583AbUISEjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269583AbUISEjI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 00:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269587AbUISEjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 00:39:07 -0400
Received: from gate.crashing.org ([63.228.1.57]:30391 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269583AbUISEjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 00:39:04 -0400
Subject: Re: udev is too slow creating devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: Greg KH <greg@kroah.com>, Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <414C9003.9070707@softhome.net>
References: <414C9003.9070707@softhome.net>
Content-Type: text/plain
Message-Id: <1095568704.6545.17.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 19 Sep 2004 14:38:24 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>    You need to change your attitude for first. For second - come up with 
> a way for user space to block until device is here, and if it is not 
> here/error detected - fail.
> 
>    As it was said before - /all/ we need, is to be able to tell 
> discovery phase from idle state of driver. "/All/" is quite much here - 
> but it must be a goal.
> 
>    I'm absolutely sure, that for PCI devices it is implementable quite 
> easy - probing is already done outside of modules. And we know precisely 
> are we Ok, or are we not. And we know when we are done. If it is not so 
> for USB yet - then it is bug which must be fixed.

Nope, Greg is right. Drivers themselves won't necessarily provide
you with the device interface in a synchronous way after they are
loaded, and some will certainly never. It is all an asynchronous process
and there is simply no way to ask for any kind of enforced synchronicity
here without major bloatage.

Ben.

