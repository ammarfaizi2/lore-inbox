Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbTFGK7W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 06:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTFGK7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 06:59:22 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:8593 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S263056AbTFGK7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 06:59:21 -0400
Message-Id: <200306071112.h57BCmsG006701@ginger.cmf.nrl.navy.mil>
To: Werner Almesberger <wa@almesberger.net>
cc: Mitchell Blank Jr <mitch@sfgoth.com>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2) 
In-reply-to: Your message of "Fri, 06 Jun 2003 20:19:06 -0300."
             <20030606201906.F3232@almesberger.net> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Sat, 07 Jun 2003 07:10:58 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030606201906.F3232@almesberger.net>,Werner Almesberger writes:
>It could probably be used to leverage other security holes in
>atmsigd. (Not that I'm aware of any, but I'd be surprised if
>there were none.)

well various bits of the atm library used to use vsprintf.  we changed
this to vsnprintf just to avoid trouble.  i couldnt see how it might be
possible for someone to send a call setup that would overflow the debug
format buffer but better safe than sorry.
