Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbTFINtp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 09:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbTFINtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 09:49:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:18324 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261960AbTFINto (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 09:49:44 -0400
Date: Mon, 09 Jun 2003 07:00:14 -0700 (PDT)
Message-Id: <20030609.070014.118613484.davem@redhat.com>
To: chas@cmf.nrl.navy.mil
Cc: baldrick@wanadoo.fr, wa@almesberger.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2) 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200306091400.h59E0bsG022093@ginger.cmf.nrl.navy.mil>
References: <20030609.063825.123987226.davem@redhat.com>
	<200306091400.h59E0bsG022093@ginger.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@cmf.nrl.navy.mil>
   Date: Mon, 09 Jun 2003 09:58:45 -0400

   >ATM should unlink them immediately, and mark them dead.
   >Anything that tries to do something with a VCC should
   >check that it is still alive.
   
   i imagine marking vcc->dev = NULL would be pretty close to the above.

Yep.  That'd work.

   (see latest rfc patch).
   
You do know that won't compile with current 2.5.x right?
All the struct sock members got renamed to have a "sk_" prefix
2 days ago :-)

But I did like the general direction you were going in.  I can't
comment on things like getting rid of ATM_*_ITF or whatever it's
called because I don't know what that thing does ;)
