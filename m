Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTFFX4l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 19:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbTFFX4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 19:56:41 -0400
Received: from almesberger.net ([63.105.73.239]:40458 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262373AbTFFX4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 19:56:40 -0400
Date: Fri, 6 Jun 2003 21:10:05 -0300
From: Werner Almesberger <wa@almesberger.net>
To: chas williams <chas@cmf.nrl.navy.mil>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2)
Message-ID: <20030606211005.H3232@almesberger.net>
References: <20030606121339.A3232@almesberger.net> <200306062357.h56NvlsG002943@ginger.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306062357.h56NvlsG002943@ginger.cmf.nrl.navy.mil>; from chas@cmf.nrl.navy.mil on Fri, Jun 06, 2003 at 07:55:57PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chas williams wrote:
> wrong!  the biggest problem with the atm stack is because one
> thing isnt synchronus.  the atm recv side is completely async.
> it can pop up at anytime and try to use a vcc.

The data plane, yes. But the control/configuration plane is
synchronous. And it also makes sure that the driver stops
doing asynchronous things when removing a VCC.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
