Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbTFFO52 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 10:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTFFO52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 10:57:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1516 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261624AbTFFO51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 10:57:27 -0400
Date: Fri, 06 Jun 2003 08:08:27 -0700 (PDT)
Message-Id: <20030606.080827.118629638.davem@redhat.com>
To: chas@cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2) 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200306061507.h56F7PsG026811@ginger.cmf.nrl.navy.mil>
References: <20030606.040410.54190551.davem@redhat.com>
	<200306061507.h56F7PsG026811@ginger.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@cmf.nrl.navy.mil>
   Date: Fri, 06 Jun 2003 11:05:37 -0400

   so should i hold rtnl across add/remove atm addresses on atm dev's?
   (but iw ouldnt hold rtnl across people just reading the list of
   atm addresses right?)
   
Correct.

   i am planning (or have done) to move all the vcc's onto a global
   list (ala many of the other protocol stacks).  this makes the code
   for proc (and others) much cleaner since you just grab a read lock
   on the global vcc sklist instead of locking and interating each atm
   device.  further, this will let atm interrupt handlers block a race
   with vcc close/removal.  is this a bad plan?
   
Sounds good.
