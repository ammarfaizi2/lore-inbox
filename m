Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbTFGAjn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 20:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbTFGAjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 20:39:43 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:58250 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262426AbTFGAjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 20:39:42 -0400
Message-Id: <200306070053.h570rCsG003409@ginger.cmf.nrl.navy.mil>
To: Werner Almesberger <wa@almesberger.net>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2) 
In-reply-to: Your message of "Fri, 06 Jun 2003 21:20:26 -0300."
             <20030606212026.I3232@almesberger.net> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Fri, 06 Jun 2003 20:51:23 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030606212026.I3232@almesberger.net>,Werner Almesberger writes:
>The only thing that worries me in all this is Dave's request to
>make device destruction asynchronous, because of the complexity
>this is likely to add, for, IMHO, little or no gain.

but its actually pretty easy to do.  its similar to atmsigd
exiting.  all the vcc's (on that device) would be purged and
eventually close allowing the atm device to be removed from the kernel.
