Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbTFFPNE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 11:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbTFFPNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 11:13:04 -0400
Received: from almesberger.net ([63.105.73.239]:9481 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261861AbTFFPNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 11:13:01 -0400
Date: Fri, 6 Jun 2003 12:26:16 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "David S. Miller" <davem@redhat.com>
Cc: chas@cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2)
Message-ID: <20030606122616.B3232@almesberger.net>
References: <20030606105753.A3275@almesberger.net> <20030606.070747.48395512.davem@redhat.com> <20030606121339.A3232@almesberger.net> <20030606.081618.108808702.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030606.081618.108808702.davem@redhat.com>; from davem@redhat.com on Fri, Jun 06, 2003 at 08:16:18AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> But regardless I should be able to yank an ATM device out of the
> kernel (unregistering it) even if there are a thousand VCC's attached
> to it.

Why ? A VCC is more like a network interface than a TCP
connection.

Worse yet, if you remove the device, it's unlikely that you
can use a new one with the same physical interface before
all the old VCCs are gone. (I.e. you almost always have
things on well-known VCCs, which are associated with physical
devices.)

Removing an ATM device while there are open VCCs isn't a lot
more useful than removing a telephone while there is still a
call in progress :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
