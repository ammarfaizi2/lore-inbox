Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWIWM15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWIWM15 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 08:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWIWM15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 08:27:57 -0400
Received: from ironport-c10.fh-zwickau.de ([141.32.72.200]:22184 "EHLO
	ironport-c10.fh-zwickau.de") by vger.kernel.org with ESMTP
	id S1750825AbWIWM14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 08:27:56 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAEvEFEWLcAIN
X-IronPort-AV: i="4.09,207,1157320800"; 
   d="scan'208"; a="3399701:sNHT32583552"
Date: Sat, 23 Sep 2006 14:27:54 +0200
From: Joerg Roedel <joro-lkml@zlug.org>
To: Patrick McHardy <kaber@trash.net>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 00/03][RESUBMIT] net: EtherIP tunnel driver
Message-ID: <20060923122754.GE32284@zlug.org>
References: <20060923120704.GA32284@zlug.org> <20060923121327.GH30245@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060923121327.GH30245@lug-owl.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2006 at 02:13:27PM +0200, Jan-Benedict Glaw wrote:

> I haven't seen the first submission, but is this driver really needed?
> Can't this be done with creating two tap interfaces on both endpoints
> and bridge them with a local ethernet device using userland software?

In general it is possible to use a tap interface to tunnel Ethernet
packets. But this driver uses the EtherIP protocol defined in RFC 3378
which itself defines an own IP protocol for it (number 97). This
protocol is also supported by different other operating systems (some of
the major BSD versions). This driver makes Linux interoperable with
these implementations.

Regards,
    Joerg Roedel
