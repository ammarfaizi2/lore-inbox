Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWDBOtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWDBOtb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 10:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWDBOta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 10:49:30 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:41172 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932354AbWDBOt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 10:49:29 -0400
Message-ID: <442FE47F.9040008@sgi.com>
Date: Sun, 02 Apr 2006 16:49:35 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: torvalds@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [patch] avoid unaligned access when accessing poll stack
References: <yq0sloytyj5.fsf@jaguar.mkp.net> <20060331102053.2a440f81.akpm@osdl.org>
In-Reply-To: <20060331102053.2a440f81.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jes Sorensen <jes@sgi.com> wrote:
>>   [PATCH] Optimize select/poll by putting small data sets on the stack
>>  resulted in the poll stack being 4-byte aligned on 64-bit
>>  architectures, causing misaligned accesses to elements in the array.
> 
> How come you noticed this but I did not?

Heh,

The ia64 kernel spits out nifty little messages moaning about this since
it goes to firmware emulation. They were all in the middle of the bootup
messages making them a bit harder to notice as well.

Cheers,
Jes
