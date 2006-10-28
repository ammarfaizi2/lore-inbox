Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbWJ1Wa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWJ1Wa2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 18:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWJ1Wa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 18:30:28 -0400
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:57716 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964896AbWJ1Wa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 18:30:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=CwHAJNX6UxGsV4c2bBxF7Nw9Xq/2A29ByPGePU8jti4eyZRM8zH+qnWxbxfRTZ1H6j22shZ6NIZA5UXe8fOQpvLk5EIx/3vXDTc8oY19WEZ0JqVD1b36h+4u/N9ADQbJTvZzIhLwNPGFgTnOqx1O0JxCCaf+oWevb/OGLaaJ9y0=  ;
From: David Brownell <david-b@pacbell.net>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/2] usbnet: use MII hooks only if CONFIG_MII is enabled
Date: Sat, 28 Oct 2006 15:30:18 -0700
User-Agent: KMail/1.7.1
Cc: akpm@osdl.org, greg@kroah.com, link@miggy.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Randy Dunlap <randy.dunlap@oracle.com>, toralf.foerster@gmx.de,
       torvalds@osdl.org, zippel@linux-m68k.org
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <200610281410.13679.david-b@pacbell.net> <20061028211342.GA23360@infradead.org>
In-Reply-To: <20061028211342.GA23360@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610281530.22743.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 October 2006 2:13 pm, Christoph Hellwig wrote:
> 
> I still don't quite like the approach.  What about simply putting
> the mii using functions into usbnet-mii.c and let makefile doing
> all the work?  This would require a second set of ethtool ops,
> but I'd actually consider that a cleanup, as it makes clear which
> one we're using and allows to kill all the checks for non-mii
> hardware in the methods.

Feel free to do such a patch yourself, so long as the MII doesn't
go into a separate module.  You'll have to also modify the two
Ethernet adapters currently using that usbnet core code (and MII).

That'd still feel like needless complexity to me, though.  So
unless you're keen on doing that quickly, I'd say to just merge
the two existing patches and be done with it.

- Dave
