Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWGXTAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWGXTAw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 15:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWGXTAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 15:00:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52666 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932154AbWGXTAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 15:00:51 -0400
Message-ID: <44C518D6.3090606@redhat.com>
Date: Mon, 24 Jul 2006 15:00:38 -0400
From: Rik van Riel <riel@redhat.com>
Organization: Red Hat, Inc
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm <linux-mm@kvack.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: inactive-clean list
References: <1153167857.31891.78.camel@lappy> <44C30E33.2090402@redhat.com> <Pine.LNX.4.64.0607241109190.25634@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0607241109190.25634@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Sun, 23 Jul 2006, Rik van Riel wrote:
> 
>> This patch makes it possible to implement Martin Schwidefsky's
>> hypervisor-based fast page reclaiming for architectures without
>> millicode - ie. Xen, UML and all other non-s390 architectures.
>>
>> That could be a big help in heavily loaded virtualized environments.
>>
>> The fact that it helps prevent the iSCSI memory deadlock is a
>> huge bonus too, of course :)
> 
> I think there may be a way with less changes to the way the VM functions 
> to get there:

That approach probably has way too many state changes going
between the guest OS and the hypervisor...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
