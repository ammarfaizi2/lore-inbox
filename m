Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWCPR6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWCPR6c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 12:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWCPR6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 12:58:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43499 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932442AbWCPR6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 12:58:31 -0500
Date: Thu, 16 Mar 2006 09:55:08 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: Greg Scott <GregScott@InfraSupportEtc.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
       Bart Samwel <bart@samwel.tk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Simon Mackinlay <smackinlay@mail.com>
Subject: Re: Router stops routing after changing MAC Address
Message-ID: <20060316095508.00281efd@localhost.localdomain>
In-Reply-To: <20060316160743.GA13035@taniwha.stupidest.org>
References: <925A849792280C4E80C5461017A4B8A20321F2@mail733.InfraSupportEtc.com>
	<20060313100041.212cee08@localhost.localdomain>
	<20060316160743.GA13035@taniwha.stupidest.org>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2006 08:07:43 -0800
Chris Wedgwood <cw@f00f.org> wrote:

> On Mon, Mar 13, 2006 at 10:00:41AM -0800, Stephen Hemminger wrote:
> 
> > There still is a bug in the 3c59x driver.  It doesn't include any
> > code to handle changing the mac address.  It will work if you take
> > the device down, change address, then bring it up. But you shouldn't
> > have to do that.
> 
> I sent a patch do to this probably a year or two back and it was
> rejected (by akpm if I recall) because of the argument that you could
> and should take it down, change the MAC and bring it back up.
> 
> Is this no longer a requirement?

No. most drivers allow changes on the fly.
