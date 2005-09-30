Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbVI3A3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbVI3A3H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 20:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbVI3A3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 20:29:07 -0400
Received: from gate.crashing.org ([63.228.1.57]:33921 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932407AbVI3A3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 20:29:05 -0400
Subject: Re: iMac G5: experimental thermal & cpufreq support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <433C7882.20000@am.sony.com>
References: <1127978432.6102.53.camel@gaston>  <433C7882.20000@am.sony.com>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 10:26:59 +1000
Message-Id: <1128040019.31197.3.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-29 at 16:28 -0700, Geoff Levand wrote:
> Benjamin Herrenschmidt wrote:
> > The algorithm itself is extracted from darwin. However, it's a rather
> > complex modified version of the PID algorithm, and thus it could use
> > some review to make sure I got everything right.
> > 
> 
> As we are already in the digital domain, I would think it would be 
> more savvy to use a digital controller than try to simulate an
> analog controller...  Why don't you abstract the control algorithm 
> such that you can plug in others as they are developed.

Because I don't know much about those control algorithms, and all the
calibration data provided by the firmware is in the form of factors for
these algorithms, I wouldn't know how to "unmangle" them to use with
different ones.

Actually, the control algorithms (PID and modified PID) are in a
"helper", so it's fairly easy for the platform module to use whatever it
wants, feel free to submit other algorithms :) But for Apple machines,
I'd rather use what I have calibration data for, unless you can produce
something that works without any...

Ben.

