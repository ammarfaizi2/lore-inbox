Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbTFGAco (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 20:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbTFGAco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 20:32:44 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:51338 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262429AbTFGAcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 20:32:43 -0400
Message-Id: <200306070046.h570kBsG003360@ginger.cmf.nrl.navy.mil>
To: Werner Almesberger <wa@almesberger.net>
cc: Mitchell Blank Jr <mitch@sfgoth.com>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2) 
In-reply-to: Your message of "Fri, 06 Jun 2003 20:19:06 -0300."
             <20030606201906.F3232@almesberger.net> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Fri, 06 Jun 2003 20:44:22 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030606201906.F3232@almesberger.net>,Werner Almesberger writes:
>Naw, it isn't supposed to do that :-) I wonder if anyone
>actually made functional changes to atmsigd (or qgen ;-) since
>I last touched it ...

we (in particualr ekinize) added point to multipoint signalling.
its mostly handled in user space (atmsigd).  some changes will be
needed when we support vbr. 

>But yes, with a unified VCC table, it certainly makes sense to
>add a hash to validate those pointers. I still think that using
>pointers per se is a good idea, because they're naturally
>unique numbers. Given that a VCC can be in all kinds of states,

at that point we would probably just fix it to use the netlink
interface (or whatever is going to be the acceptable interface)
