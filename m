Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751923AbWIRVqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbWIRVqR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 17:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbWIRVqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 17:46:17 -0400
Received: from minus.inr.ac.ru ([194.67.69.97]:11440 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S1751923AbWIRVqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 17:46:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=WSkwUIPhl2soh1tyygv7bQyjlkuw+EdQDNP6PYyrBteF60J/b/AJqobGN+JgTS2N6J4BBQXr/ZI5fANdP5Rfm2ndAWwVdQDDw7dED3gFci1TjZll58gJeUbxjW7AydH/S/KOQviCoRS8p0rCNt3yTiEIoHW93AT6K15k0dsBG1k=;
Date: Tue, 19 Sep 2006 01:46:01 +0400
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: David Miller <davem@davemloft.net>
Cc: ak@suse.de, master@sectorb.msk.ru, hawk@diku.dk,
       harry@atmos.washington.edu, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
Message-ID: <20060918214601.GA14322@ms2.inr.ac.ru>
References: <20060918162847.GA4863@ms2.inr.ac.ru> <200609181850.22851.ak@suse.de> <20060918210321.GA4780@ms2.inr.ac.ru> <20060918.142247.14844785.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060918.142247.14844785.davem@davemloft.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Ok, ok, but don't we have queueing disciplines that need the timestamp
> even on ingress?

I cannot find.

ip_queue does. But it is just another user, not different of sockets.

BTW in any case, any user of timestamp who sees 0, because skb was received
before timestamping was enabled, has to calculate timestamp itself right
in the place where Andi suggested. Seems, preparation to the change
makes sense even without the change. :-)

Alexey

