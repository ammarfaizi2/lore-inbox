Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbTFFXo3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 19:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbTFFXo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 19:44:28 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:30601 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262373AbTFFXoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 19:44:24 -0400
Message-Id: <200306062357.h56NvlsG002943@ginger.cmf.nrl.navy.mil>
To: Werner Almesberger <wa@almesberger.net>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2) 
In-reply-to: Your message of "Fri, 06 Jun 2003 12:13:39 -0300."
             <20030606121339.A3232@almesberger.net> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Fri, 06 Jun 2003 19:55:57 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030606121339.A3232@almesberger.net>,Werner Almesberger writes:
>make sense. But in the case of ATM device and VCC handling, you
>already have all the synchronous code paths (because things are
>initiated by user space), they're not very timing-critical, and
>reuse before destruction has completed is unlikely.

wrong!  the biggest problem with the atm stack is because one
thing isnt synchronus.  the atm recv side is completely async.
it can pop up at anytime and try to use a vcc.
