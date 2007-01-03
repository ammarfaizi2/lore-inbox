Return-Path: <linux-kernel-owner+w=401wt.eu-S1751042AbXACSdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbXACSdY (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 13:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbXACSdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 13:33:24 -0500
Received: from gate.crashing.org ([63.228.1.57]:49744 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751030AbXACSdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 13:33:23 -0500
In-Reply-To: <20070102235733.GG18033@redhat.com>
References: <20070102235733.GG18033@redhat.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f8de460d3c5489f3b1ec407e5d8d8c0b@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, mingo@redhat.com
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: inaccurate migration cost calculation?
Date: Wed, 3 Jan 2007 19:33:52 +0100
To: Dave Jones <davej@redhat.com>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Across different boots using the same 2.6.19 kernel on a quad-core xeon
> I see huge variance in the migration_cost being reported during boot.
>
> -migration_cost=39,3940
> +migration_cost=25,4941
>
> This CPU has a very large cache which could be key here...
>  L1 Instruction cache: 32KB, 8-way associative. 64 byte line size.
>  L1 Data cache: 32KB, 8-way associative. 64 byte line size.
>  L3 unified cache: 4MB, 16-way associative. 64 byte line size.

That last cache is shared between CPU cores, which leads
to big non-determinism -- not sure if there's much you can
do about it.


Segher

