Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWAQAYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWAQAYQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 19:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWAQAYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 19:24:16 -0500
Received: from elvis.mu.org ([192.203.228.196]:32967 "EHLO elvis.mu.org")
	by vger.kernel.org with ESMTP id S1751312AbWAQAYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 19:24:15 -0500
Message-ID: <43CC3922.2070205@FreeBSD.org>
Date: Mon, 16 Jan 2006 16:24:02 -0800
From: Suleiman Souhlal <ssouhlal@FreeBSD.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Andrea Arcangeli <andrea@suse.de>, Badari Pulavarty <pbadari@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       hugh@veritas.com, dvhltc@us.ibm.com, linux-mm@kvack.org,
       blaisorblade@yahoo.it, jdike@addtoit.com
Subject: Re: differences between MADV_FREE and MADV_DONTNEED
References: <20051102014321.GG24051@opteron.random>	<1130947957.24503.70.camel@localhost.localdomain>	<20051111162511.57ee1af3.akpm@osdl.org>	<1131755660.25354.81.camel@localhost.localdomain>	<20051111174309.5d544de4.akpm@osdl.org> <43757263.2030401@us.ibm.com>	<20060116130649.GE15897@opteron.random> <43CBC37F.60002@FreeBSD.org>	<20060116162808.GG15897@opteron.random> <43CBD1C4.5020002@FreeBSD.org>	<20060116172449.GL15897@opteron.random> <m1r777rgq4.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1r777rgq4.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> As I recall the logic with DONTNEED was to mark the mapping of
> the page clean so the page didn't need to be swapped out, it could
> just be dropped.
> 
> That is why they anonymous and the file backed cases differ.
> 
> Part of the point is to avoid the case of swapping the pages out if
> the application doesn't care what is on them anymore.

Well, imho, MADV_DONTNEED should mean "I won't need this anytime soon", 
and MADV_FREE "I will never need this again".

-- Suleiman
