Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbTFGAr2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 20:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbTFGArN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 20:47:13 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:63114 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262456AbTFGAo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 20:44:26 -0400
Message-Id: <200306070057.h570vtsG003449@ginger.cmf.nrl.navy.mil>
To: Werner Almesberger <wa@almesberger.net>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2) 
In-reply-to: Your message of "Fri, 06 Jun 2003 21:10:05 -0300."
             <20030606211005.H3232@almesberger.net> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Fri, 06 Jun 2003 20:56:06 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030606211005.H3232@almesberger.net>,Werner Almesberger writes:
>The data plane, yes. But the control/configuration plane is
>synchronous. And it also makes sure that the driver stops
>doing asynchronous things when removing a VCC.

but parts of the control/config plane still arent synchronus.
how about atm_async_release()?  actually i believe its up to
the driver author to make sure that a vcc isnt used after the
close completes.  but very few (if any) try to do this.  
