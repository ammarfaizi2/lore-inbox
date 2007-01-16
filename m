Return-Path: <linux-kernel-owner+w=401wt.eu-S1751258AbXAPPin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbXAPPin (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 10:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbXAPPin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 10:38:43 -0500
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:63735 "EHLO
	pne-smtpout3-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751258AbXAPPin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 10:38:43 -0500
X-Greylist: delayed 4148 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jan 2007 10:38:43 EST
Date: Tue, 16 Jan 2007 16:29:31 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I broke my port numbers :(
Message-ID: <20070116142931.GC3771@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20070115215515.GA3771@m.safari.iki.fi> <20070115224801.GB3771@m.safari.iki.fi> <Pine.LNX.4.61.0701161457240.23841@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0701161457240.23841@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2007 at 14:57:56 +0100, Jan Engelhardt wrote:
> 
> >Subject: Re: I broke my port numbers :(
> >
> >On Mon, Jan 15, 2007 at 23:55:15 +0200, Sami Farin wrote:
> >> I know this may be entirely my fault but I have tried reversing
> >> all of my _own_ patches I applied to 2.6.19.2 but can't find what broke this.
> >> I did three times "netcat 127.0.0.69 42", notice the different
> >> port numbers.
> >
> >Hmm...  when I do "rmmod iptable_nat ip_nat", it works.
> 
> Then please show us your rulset that was loaded (iptables-save) before 
> you removed the modules.

For -t nat I had only

-t nat    -P PREROUTING   ACCEPT
-t nat    -P POSTROUTING  ACCEPT
-t nat    -P OUTPUT       ACCEPT

but due to my modifications to ip_nat_proto_tcp.c
it broke (ip_nat_proto_tcp.c wasn't supposed to get used,
anyways).

-- 
