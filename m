Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262131AbVFRPOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbVFRPOu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 11:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVFRPOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 11:14:50 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:64990 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262131AbVFRPOs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 11:14:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gmGO79OJX5gp7lkHUZAn89HmAkKXOFHpecCNy+DqUU040OHPLifWswhTwlBplJQBD1ngjmel44EKSIpKeU+j8iKneUxHD+OmlF9U5fHs0Ct3xuSxxNJpO9UhSjggU0Zru20bdTZrEjiTJL0p0UcC8/HPDpNQntFSTT9CQJC7UUI=
Message-ID: <876ef97a05061808141d503f58@mail.gmail.com>
Date: Sat, 18 Jun 2005 11:14:45 -0400
From: Tobias DiPasquale <codeslinger@gmail.com>
Reply-To: Tobias DiPasquale <codeslinger@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Chris Rankin <rankincj@yahoo.com>
Subject: Re: 2.6.12: connection tracking broken?
Cc: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0506181656250.20828@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050618124359.39052.qmail@web52901.mail.yahoo.com>
	 <Pine.LNX.4.61.0506181656250.20828@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/05, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> >I have just tried upgrading my firewall to 2.6.12, but neither of the following rules in my
> >FORWARD table was allowing return traffic:
> 
> You forget about INPUT and OUTPUT. If you drop everything in INPUT, there's
> nothing to FORWARD.

No. INPUT/OUTPUT rules have nothing to do with FORWARDed traffic,
since a packet is either locally destined (INPUT), locally originated
(OUTPUT) or being forwarded (FORWARD).

> > 1109  814K ACCEPT     all  --  ppp0   br0     anywhere             anywhere         ctstate
> >RELATED,ESTABLISHED
> >  11M   13G ACCEPT     all  --  ppp0   br0     anywhere             anywhere         state
> >RELATED,ESTABLISHED
> >
> >I have currently returned to using 2.6.11.11, where the identical configuration works fine. br0 is
> >a bridge device containing two e100 devices, and ppp0 is my PPPoE DSL link. I am using iptables
> >1.3.1.

Did you have /proc/sys/net/ipv4/ip_forward turned on?

-- 
[ Tobias DiPasquale ]
0x636f6465736c696e67657240676d61696c2e636f6d
