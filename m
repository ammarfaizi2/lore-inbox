Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbULXTXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbULXTXY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 14:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbULXTXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 14:23:24 -0500
Received: from web51506.mail.yahoo.com ([206.190.38.198]:57982 "HELO
	web51506.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261437AbULXTXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 14:23:15 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=jegRsKm5DEtdIjhUYieV00MTVWI7q18XO0fVk3RGgGkKPyiV9yjGta3E3AGPIRj3x6zUVARG8b5wsedas6Fn/i7O6QljAzDprohDgwiU/efXppB+DdACJPZGXruMlMA2xXGghaSujbh6M+hxtwd6cWAZfOzCqjVEc6GqrGQu6xw=  ;
Message-ID: <20041224192311.67180.qmail@web51506.mail.yahoo.com>
Date: Fri, 24 Dec 2004 11:23:11 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: [Ipsec] Issue on input process of Linux native IPsec
To: David Dillow <dave@thedillows.org>
Cc: ipsec@ietf.org, ipsec-tools-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
In-Reply-To: <1103869407.3016.7.camel@ori.thedillows.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2004 at 01:23, David Dillow wrote:
> On Wed, 2004-12-22 at 22:29 -0800, Park Lee wrote:
> > Thanks.
> > But, After a packet was received, It has already 
> > been processed by xfrm4_rcv(), xfrm4_rcv_encap(),
> > ah_input(), esp_input(),etc. so, I think that 
> > there is no need to search(or created) a bundle 
> > everytime a packet is recieved, since it has 
> > already been processed. Am I right?
>
> Are you sure you're not seeing the creation of a 
> reply packet? Unless you're testing with UDP and a 
> listening socket on the receiver, you're going to 
> get a response packet if the incoming packet makes 
> it through the iptables rules. You were testing 
> with ICMP echo requests (ping), if I recall.
>
> I think either you're basing your idea of the 
> packet flow on printk()'s,or I'm just too tired and 
> missing where xfrm_lookup() gets called on the
> rx path... 

Yes, I'm testing with ping and basing my idea of the
packet flow on printk().

> (yes, sk can be NULL there, but I was wrong about 
> it being called for Rx'd packets, I think).

Does this mean that when the reply (response) packet
is sending out through xfrm_lookup(), the sk parameter
of xfrm_lookup() will not be NULL? and When the
incoming packet itself goes through xfrm_lookup(), the
sk parameter will be NULL?

Thank you 
and 
Merry Christmas.


=====
Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Helps protect you from nasty viruses. 
http://promotions.yahoo.com/new_mail
