Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbVIHL6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbVIHL6W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 07:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbVIHL6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 07:58:22 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:56774 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S1751317AbVIHL6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 07:58:20 -0400
Date: Thu, 8 Sep 2005 13:58:05 +0200 (CEST)
From: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Netdev List <netdev@vger.kernel.org>
Subject: Re: [PATCH] 3c59x: read current link status from phy
In-Reply-To: <431F9899.4060602@pobox.com>
Message-ID: <Pine.LNX.4.63.0509081351160.21354@dingo.iwr.uni-heidelberg.de>
References: <200509080125.j881PcL9015847@hera.kernel.org> <431F9899.4060602@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Sep 2005, Jeff Garzik wrote:

>> The phy status register must be read twice in order to get the actual link
>> state.

Can the original poster give an explanation ? I've enjoyed a rather 
well functioning 3c59x driver for the past ~6 years without such 
double reading. Plus:
- this operation is I/O expensive
- it is performed inside a region protected by a spinlock
- it is performed often, every 60 seconds

Is there some specific hardware that exhibits a problem that is solved 
by this double reading ?

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De
