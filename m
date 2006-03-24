Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWCXPuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWCXPuz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 10:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWCXPuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 10:50:55 -0500
Received: from fmr17.intel.com ([134.134.136.16]:65180 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932104AbWCXPuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 10:50:54 -0500
Message-ID: <44241552.5020503@linux.intel.com>
Date: Fri, 24 Mar 2006 16:50:42 +0100
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Ashok Raj <ashok.raj@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Ignore MCFG if the mmconfig area isn't reserved in thee820
 table
References: <1143138170.3147.43.camel@laptopd505.fenrus.org> <200603241639.54192.ak@suse.de> <44241359.3070409@linux.intel.com> <200603241648.19901.ak@suse.de>
In-Reply-To: <200603241648.19901.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Friday 24 March 2006 16:42, Arjan van de Ven wrote:
>> Andi Kleen wrote:
>>> In theory they should be the same. What do you think is different?
>> in practice the x86-64 version returns "success" if there is one byte in the entire
>> memory range that complies with the requested type, even if the rest of the range is
>> of another type. 
> 
> I would consider that a bug. Please send fix.

I'm less sure. It's what the function does, and I can see very valid usage models for it;
to detect that a certain type is NOT present. And the code is clearly written with that goal
in mind at least. I'm tempted to write a real range function but I also was hoping to avoid
doing that, since for the MCFG test it really is a bit overkill.



