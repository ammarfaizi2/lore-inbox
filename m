Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVAGIHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVAGIHD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 03:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbVAGIHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 03:07:03 -0500
Received: from dialpool3-195.dial.tijd.com ([62.112.12.195]:33153 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S261306AbVAGIG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 03:06:56 -0500
From: Jan De Luyck <lkml@kcore.org>
To: Julian Anastasov <ja@ssi.bg>
Subject: Re: ARP routing issue
Date: Fri, 7 Jan 2005 09:06:57 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
References: <200501061647.45226.lkml@kcore.org> <Pine.LNX.4.58.0501070935240.1636@u.domain.uli>
In-Reply-To: <Pine.LNX.4.58.0501070935240.1636@u.domain.uli>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501070906.59146.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 January 2005 08:44, Julian Anastasov wrote:
>  Hello,
>
> On Thu, 6 Jan 2005, Jan De Luyck wrote:
> > http://www.uwsg.iu.edu/hypermail/linux/net/0308.1/0071.html
> >
> > Basically it comes down to this:
> >
> > I have an IBM server running RH ES, kernel 2.4.9-e.49. It has two
> > interfaces: eth0 10.0.22.xxx
> > eth1 10.0.24.xxx
> >
> > default gateway is set to 10.0.22.1, on eth0.
> >
> > Problem is, if I try to ping from another network (10.216.0.xx) to
> > 10.0.24.xx, i see the following ARP request:
> >
> > arp who-has 10.0.22.1 tell 10.0.24.xx
> >
> > which, imo, is wrong.
> >
> > I know it has to do with the default gatway, but I can't devise a way to
> > make it actually _WORK_.
>
>  Not wrong but it is one of the possible valid requests. 

Yes, I've gathered that. Yet, it seems very strange, and I want to _change_ 
that behaviour.

>  If it 
> is ignored from other boxes in your setup then you can look
> at new kernels. 2.4.26 and 2.6.4 come with new sysctl flags for ARP.
> arp_filter filters incoming requests but you can use arp_announce to
> control the source IP when sending requests, eg. in IBM server you can set
> /proc/sys/net/ipv4/conf/eth*/arp_announce to 1 or 2 or even just
> /proc/sys/net/ipv4/conf/all/arp_announce to 1 or 2

Hmm. Point is, for certification/support reasons we'd rather stick to the 
RedHat ES supplied kernels instead of starting off with one of our own. I 
can't go off running non-checked-to-be-stable (in a business POV) code on 
mission-critical systems. (2.6.10 is stable enough in _my_ POV, but well..)

Jan

-- 
Serfs up!
  -- Spartacus
