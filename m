Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbWAKRNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWAKRNU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 12:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbWAKRNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 12:13:20 -0500
Received: from rtr.ca ([64.26.128.89]:19148 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751467AbWAKRNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 12:13:19 -0500
Message-ID: <43C53CA2.7070002@rtr.ca>
Date: Wed, 11 Jan 2006 12:13:06 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Greg Norris <haphazard@kc.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH ]  VMSPLIT config options (with default config fixed)
References: <20060110132957.GA28666@elte.hu> <20060110133728.GB3389@suse.de> <Pine.LNX.4.63.0601100840400.9511@winds.org> <20060110143931.GM3389@suse.de> <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org> <43C3E9C2.1000309@rtr.ca> <20060110173217.GU3389@suse.de> <43C3F0CA.10205@rtr.ca> <43C403BA.1050106@pobox.com> <43C40803.2000106@rtr.ca> <20060111160050.GA5472@yggdrasil.localdomain>
In-Reply-To: <20060111160050.GA5472@yggdrasil.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Norris wrote:
> Is there any benefit/point to enabling HIGHMEM when using this patch, 
> assuming that physical memory is smaller than the address space?  For 
> example, when using VMSPLIT_3G_OPT on a box with 1G of memory.

No.  In fact, there should be a (very) tiny performance gain
by NOT enabling HIGHMEM -- things like kmap() should get simpler.

Cheers
