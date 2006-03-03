Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWCCEoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWCCEoq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 23:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWCCEoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 23:44:46 -0500
Received: from smtp105.rog.mail.re2.yahoo.com ([206.190.36.83]:3940 "HELO
	smtp105.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751142AbWCCEoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 23:44:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=PoPEKEPbpw9Xz/HlwSesPOXCGz0QhQZERJohz2IQzbwWNIITwAA+TalBRMc1MBrLPOEBFuSA0WbE2VALkkFiikzXLDP+OYD7gs3axFIOc6TQGL0fkyzp+blga1GkFB/zVd33ZUaYu86/7AVyw9cmM34vjpTVe26uT1LVUvPuTyw=  ;
Subject: Re: [2.6 patch] make UNIX a bool
From: "James C. Georgas" <jgeorgas@rogers.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060302214423.GI9295@stusta.de>
References: <20060301175852.GA4708@stusta.de>
	 <E1FEcfG-000486-00@gondolin.me.apana.org.au>
	 <20060302173840.GB9295@stusta.de>
	 <9a8748490603021228k7ad1fb5gd931d9778307ca58@mail.gmail.com>
	 <20060302203245.GD9295@stusta.de> <1141335521.3582.14.camel@Rainsong.home>
	 <20060302214423.GI9295@stusta.de>
Content-Type: text/plain
Date: Thu, 02 Mar 2006 23:44:57 -0500
Message-Id: <1141361097.3582.40.camel@Rainsong.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-03 at 22:44 +0100, Adrian Bunk wrote:

> > > 
> > > We do not have to export symbols we don't want to export to modules but 
> > > needed by CONFIG_UNIX.
> > 
> > Sorry, I must just be dense, or something.
> > 
> > Is not the only difference between a modular driver and a built in
> > driver supposed to be the initialization and cleanup functions?
> > 
> > I don't see why you would have to expose any additional symbols, over
> > and above the existing required symbols, to load your module.
> 
> Every kernel symbol a module uses must be explicitely exported with 
> EXPORT_SYMBOL.
> 

Yes, I understand that I need to export symbols to define the interface
to my driver. whether its a module or compiled in. This is how other
systems interact with my driver, right?

> CONFIG_UNIX uses symbols that are neither used by any other in-kernel 
> modules nor should be exported.
> 

Are you saying that AF_UNIX has to export symbols for its own private
functions in order to call them? I guess I don't understand this. Why
not just call them. They're in scope within the driver code, aren't
they?


> > James C. Georgas <jgeorgas@rogers.com>
> 
> cu
> Adrian
> 

-- 
James C. Georgas <jgeorgas@rogers.com>

