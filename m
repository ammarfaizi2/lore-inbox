Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267605AbTAQQT1>; Fri, 17 Jan 2003 11:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267607AbTAQQT1>; Fri, 17 Jan 2003 11:19:27 -0500
Received: from havoc.daloft.com ([64.213.145.173]:17039 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267605AbTAQQTY>;
	Fri, 17 Jan 2003 11:19:24 -0500
Date: Fri, 17 Jan 2003 11:28:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org, Florian Lohoff <flo@rfc822.org>
Cc: netdev@oss.sgi.com
Subject: Re: eepro100 - 802.1q - mtu size
Message-ID: <20030117162818.GA1074@gtf.org>
References: <20030117145357.GA1139@paradigm.rfc822.org> <20030117160840.GR12676@stingr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030117160840.GR12676@stingr.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2003 at 07:08:40PM +0300, Paul P Komkoff Jr wrote:
> Replying to Florian Lohoff:
> > Why is this patch not integerated yet ?
> 
> Because newer and better e100 driver, which accepts tagged frames and
> handles it properly, already in the tree

Regardless, people still use eepro100, so I would still like to get
eepro100 doing VLAN.

The reason why the patch was not accepted is that it changes one magic
number to another magic number, and without chipset docs, I had no idea
what either magic number really meant.

Now that Intel has released chipset docs, this is an excellent time to
re-evaluate those eepro100 VLAN changes.  I still refuse to accept a
"change the magic numbers" patch... any change will need to define
a constant that describes the bits we wish to set/clear.

Download the e100 documentation from the e1000 sourceforge site:
http://sourceforge.net/projects/e1000
["8255x Developer Manual"]

	Jeff




