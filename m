Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965192AbWIEHKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965192AbWIEHKj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 03:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965197AbWIEHKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 03:10:39 -0400
Received: from mga05.intel.com ([192.55.52.89]:38688 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S965194AbWIEHKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 03:10:38 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,209,1154934000"; 
   d="scan'208"; a="125892109:sNHT24771012"
Message-ID: <44FD22E8.8080309@linux.intel.com>
Date: Tue, 05 Sep 2006 09:10:32 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Voluspa <lista1@comhem.se>, arjan@infradead.org,
       linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [PATCH] lockdep: disable lock debugging when kernel state becomes
 untrusted
References: <20060814030954.c3a57e05.lista1@comhem.se>	<20060813184159.b536736f.akpm@osdl.org>	<20060905084042.20966381.lista1@comhem.se> <20060904235549.f8f6eaab.akpm@osdl.org>
In-Reply-To: <20060904235549.f8f6eaab.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 5 Sep 2006 08:40:42 +0200
> Voluspa <lista1@comhem.se> wrote:
> 
>>> That would appear to be a bug.  debug_locks_off() is running
>>> console_verbose() waaaay after the locking selftest code has
>>> completed.
>> The possibly final -rc6 is likewise broken. What would it take to incur
>> some respect for us, the millions of users effected by this shit?
>> Should we all become quasi-developers and bombard lkml with patches
>> that taint the kernel whenever some of the Intel binary blobs are
>> loaded?

don't use those btw, they're ancient and unneeded/superceded since ages.

>>
>> Would that cluebat Arjan off of his high horse?
> 
> Thanks for the reminder ;)
> 
> Arjan, what's that console_verbose() doing in debug_locks_off()?  Whatever
> it is, can we fix it?  Presumably the previous loglevel needs to be
> readopted somehow, or we just take it out of there.

I'd say take them out of there; I don't know why they're there in the first place.. Ingo ?
