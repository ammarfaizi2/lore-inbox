Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWIDGkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWIDGkq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 02:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWIDGkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 02:40:46 -0400
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:4237 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932362AbWIDGkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 02:40:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:Received:Date:From:To:Subject:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=lI6YZnKt2zcGkN5/J1iIfr89iIcNNwcBt3xJ85wWzjvf9NFWwctwEcFRDbGRI+1SjEE17OX2Soe4wiOoE4MuZ69Gs7nNo15TJy8ZHffM7X4CRJrGJvKzXcl58wvWw9u3T/bzqw0CQptAeFMWJ3kV/GR/nUdiHUzioPk5sHftQG4=  ;
Date: Sun, 03 Sep 2006 23:40:42 -0700
From: David Brownell <david-b@pacbell.net>
To: arnd@arndb.de
Subject: Re: [linux-usb-devel] [PATCH] driver for mcs7830 (aka DeLOCK) USB 
 ethernet adapter
Cc: support@moschip.com, supermihi@web.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       dhollis@davehollis.com
References: <200608071500.55903.arnd.bergmann@de.ibm.com>
 <200608202207.39709.arnd@arndb.de>
 <200609020338.54932.david-b@pacbell.net>
 <200609021951.40470.arnd@arndb.de>
In-Reply-To: <200609021951.40470.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20060904064042.2E40719E185@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, the receive errors are independent from the status interrupt.
> I have now got confirmation by another user that they also
> happen on a different thinkpad when not using a USB hub, but
> with a hub everything seems fine.

Odd.  Hardware issues, I guess ... I'd like to understand better
just why high speed peripherals are acting up on root hubs.  Maybe
it's flakey motherboards ...


> > Speaking of which ... isnt this driver missing a hook to make
> > the MII stuff visible through ethtool?
>
> hmm, I wasn't aware that ethtool does this. I did check that mii-tool
> works though.

Then my main concern is gone.


> Going through the ethtool operations, I think that it should be
> possible to implement a few of them, including ETHTOOL_GREGS,
> ETHTOOL_GEEPROM, ETHTOOL_SEEPROM, ETHTOOL_NWAY_RST and ETHTOOL_GPERMADDR.
> Do you think these should be done?

I've not got much use for those, but maybe the netdev folk would
care.  That's probably not enough to hold up any merge.

- Dave


-- 
VGER BF report: U 0.499998
