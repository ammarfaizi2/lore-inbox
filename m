Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbTICIm5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 04:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbTICIm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 04:42:57 -0400
Received: from rzfoobar.is-asp.com ([217.11.194.155]:15573 "EHLO mail.isg.de")
	by vger.kernel.org with ESMTP id S261606AbTICIm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 04:42:56 -0400
From: Stefan Rompf <srompf@isg.de>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [ANNOUNCE] netplug, a daemon that handles network cables getting plugged in and out
Date: Wed, 3 Sep 2003 10:42:35 +0200
User-Agent: KMail/1.5.9
References: <1062105712.12285.78.camel@serpentine.internal.keyresearch.com> <3F4E8373.1040204@pobox.com> <20030828224553.GC23528@werewolf.able.es>
In-Reply-To: <20030828224553.GC23528@werewolf.able.es>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200309031042.54413.srompf@isg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> That would be very nice, but there is still a problem.
> Does netlink solve the fact that there are cards (at least in 2.4)
> that do not support any detection method:

even in 2.6 not all cards support link state via netlink, it requires some 
updates to the driver. Maintainers should take this as a hint to add 
netif_carrier_on()/_off() or mii_check_link()/mii_check_media()-calls ;-).

This does not hurt for 2.4 as these functions are already available there, but 
do not create notifications in the stock kernel.

Stefan
-- 
"doesn't work" is not a magic word to explain everything.
