Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbWFNF2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWFNF2x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 01:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWFNF2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 01:28:53 -0400
Received: from zcars04e.nortel.com ([47.129.242.56]:59618 "EHLO
	zcars04e.nortel.com") by vger.kernel.org with ESMTP id S964889AbWFNF2v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 01:28:51 -0400
Message-ID: <448F9E8A.1070608@nortel.com>
Date: Tue, 13 Jun 2006 23:28:42 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
CC: Chase Venters <chase.venters@clientec.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/2] in-kernel sockets API
References: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com> <20060613140716.6af45bec@localhost.localdomain> <20060613052215.B27858@openss7.org> <448F2A49.5020809@google.com> <20060613154031.A6276@openss7.org> <Pine.LNX.4.64.0606131655580.4856@turbotaz.ourhouse> <448F967A.8070801@ens-lyon.org>
In-Reply-To: <448F967A.8070801@ens-lyon.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Jun 2006 05:28:46.0544 (UTC) FILETIME=[6897FD00:01C68F73]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin wrote:

> What about GPL modules that don't want to get merged ? I don't know any
> such module that could use this API. But at least there are some webcam
> drivers that don't seem to want to be merged (I don't know why).

There are valid reasons for GPL code to not be merged into mainline.

I (and I'm sure there are others) work on GPL modules/patches that have 
no hope of making it into mainline because they're too specialized. 
Custom netfilter modules, drivers for special hardware, scheduler 
changes, additional instrumentation, etc.

Plus, we're usually working on a stabilized older version, so it's a lot 
of extra work to regenerate it against current versions to even try and 
merge it.

The source all goes to the customer but it just wouldn't make sense to 
have it in mainline.

So the "churn mainline to punish out-of-tree code" argument doesn't make 
sense to me.  If there's a good reason for the change, then go for 
it--but change just to make it hard for out of tree code is simply annoying.

Chris
