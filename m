Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbTEIXM0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 19:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263576AbTEIXM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 19:12:26 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37390 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263574AbTEIXMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 19:12:25 -0400
Message-ID: <3EBC389C.2010601@zytor.com>
Date: Fri, 09 May 2003 16:24:12 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: hammer: MAP_32BIT
References: <3EBB5A44.7070704@redhat.com> <20030509092026.GA11012@averell> <16059.37067.925423.998433@gargle.gargle.HOWL> <20030509113845.GA4586@averell> <b9gr03$42n$1@cesium.transmeta.com> <3EBC0084.4090809@redhat.com> <3EBC15B5.4070604@zytor.com> <3EBC2164.6050605@redhat.com> <3EBC29A5.1050005@techsource.com> <3EBC2996.2040908@zytor.com> <3EBC2FD7.2080007@techsource.com>
In-Reply-To: <3EBC2FD7.2080007@techsource.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:
>>
>> The purpose is that there is a slight task-switching speed advantage if
>> the address is in the bottom 4 GB.  Since this affects every process,
>> and most processes use very little TLS, this is worthwhile.
>>
>> This is fundamentally due to a K8 design flaw.
> 
> Is there an explicit check somewhere for this?  Are the page tables laid
> out differently?
>

No, there are two ways to load the FS base register: use a descriptor,
which is limited to 4 GB but is faster, or WRMSR, which is slower, but
unlimited.

	-hpa

