Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWBFJBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWBFJBZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 04:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWBFJBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 04:01:25 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:59495 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750799AbWBFJBZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 04:01:25 -0500
Message-ID: <43E710DC.4000705@sw.ru>
Date: Mon, 06 Feb 2006 12:03:24 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: devel@openvz.org
CC: Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       frankeh@watson.ibm.com, Andrey Savochkin <saw@sawoct.com>,
       Rik van Riel <riel@redhat.com>, greg@kroah.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, serue@us.ibm.com,
       alan@lxorguk.ukuu.org.uk, arjan@infradead.org
Subject: Re: [Devel] Re: [RFC][PATCH 1/5] Virtualization/containers: startup
References: <43E38BD1.4070707@openvz.org> <1139187391.5634.32.camel@localhost.localdomain>
In-Reply-To: <1139187391.5634.32.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>+static inline vps_t get_vps(vps_t vps)
>>+{
>>+	atomic_inc(&vps->refcnt);
>>+	return vps;
>>+}
>>+
>>+static inline void put_vps(vps_t vps)
>>+{
>>+	atomic_dec(&vps->refcnt);
>>+}
> 
> 
> I'm not too sure about the refcounting here .. you never destroy the
> object ? Also, why introduce your own refcounting mecanism instead of
> using existing ones ? You could probably use at least a kref to get a
> nice refcount + destructor instead of home made atomics based. Maybe
> some higher level structure if you think it makes sense (not too sure
> what this virtualization stuff is about so I can't comment on what data
> structure is appropriate here).
I replied to this in another email. Briefly:
this patch set doesn't introduce VPS/container creation/destroy 
interface yet. Only small parts.
krefs are not needed here.

Kirill

