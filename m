Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWISFzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWISFzy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 01:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWISFzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 01:55:52 -0400
Received: from ns2.suse.de ([195.135.220.15]:54949 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751162AbWISFzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 01:55:50 -0400
From: Andi Kleen <ak@suse.de>
To: David Miller <davem@davemloft.net>
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
Date: Tue, 19 Sep 2006 07:55:03 +0200
User-Agent: KMail/1.9.3
Cc: kuznet@ms2.inr.ac.ru, master@sectorb.msk.ru, hawk@diku.dk,
       harry@atmos.washington.edu, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
References: <20060918162847.GA4863@ms2.inr.ac.ru> <20060918210321.GA4780@ms2.inr.ac.ru> <20060918.142247.14844785.davem@davemloft.net>
In-Reply-To: <20060918.142247.14844785.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609190755.03713.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 September 2006 23:22, David Miller wrote:

> Ok, ok, but don't we have queueing disciplines that need the timestamp
> even on ingress?

I grepped and I can't find any. The only non SIOCGTSTAMP users of the
time stamp seem to be sunrpc and conntrack and I bet both can be converted
over to jiffies without trouble.

-Andi
