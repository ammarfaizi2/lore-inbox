Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbTFFQuj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 12:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTFFQuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 12:50:39 -0400
Received: from almesberger.net ([63.105.73.239]:36361 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262029AbTFFQui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 12:50:38 -0400
Date: Fri, 6 Jun 2003 14:03:43 -0300
From: Werner Almesberger <wa@almesberger.net>
To: chas williams <chas@cmf.nrl.navy.mil>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2)
Message-ID: <20030606140343.B3275@almesberger.net>
References: <20030606.040410.54190551.davem@redhat.com> <200306061507.h56F7PsG026811@ginger.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306061507.h56F7PsG026811@ginger.cmf.nrl.navy.mil>; from chas@cmf.nrl.navy.mil on Fri, Jun 06, 2003 at 11:05:37AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chas williams wrote:
> i am planning (or have done) to move all the vcc's onto a global list

At that point, you may also want to sanitize struct atmsvc_msg.vcc
and struct atmsvc_msg.listen_vcc through a hash, instead of blindly
trusting atmsigd.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
