Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVCACfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVCACfo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 21:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVCACfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 21:35:44 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:37988 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261203AbVCACfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 21:35:38 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Valdis.Kletnieks@vt.edu
Subject: Re: Complicated networking problem
Date: Mon, 28 Feb 2005 21:35:35 -0500
User-Agent: KMail/1.7.2
Cc: Jarne Cook <jcook@siliconriver.com.au>, linux-kernel@vger.kernel.org
References: <200502281459.31402.jcook@siliconriver.com.au> <200503010202.j2122b80025303@turing-police.cc.vt.edu>
In-Reply-To: <200503010202.j2122b80025303@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502282135.35405.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 February 2005 21:02, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 28 Feb 2005 14:59:31 +1000, Jarne Cook said:
> 
> > They are both using dhcp to the same simple network.  That's right.  Same 
> > network.  They both end up with gateway=192.168.0.1, netmask=255.255.255.0.  
> > But ofcourse they do not have the same IP addresses.
> 
> I don't suppose your network people would be willing to change it thusly:
> 
> wired ports:  gateway 192.168.0.1, netmask 255.255.255.128.0
> wireless:     gateway 192.168.128.1, netmask 255.255.255.128.0
> 
> Or move the wireless up to 192.168.1.1 if they think that would confuse things
> too much.
> 
> There's a limit to how far we should bend over backwards to support stupid
> networking decisions. 192.168 *is* a /16, might as well use it. ;)
> 
> If they won't, you're pretty much stuck with binding applications to one
> interface or another.
> 

If the goal is to primarily use wired link and seamlessly swith to wireless
then look into bonding driver in failover mode with wired interface as 
primary. This way you have only one address and userspace does not notice
anything.
 
-- 
Dmitry
