Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbWHWPgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWHWPgU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 11:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWHWPgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 11:36:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40591 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964983AbWHWPgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 11:36:19 -0400
Message-ID: <44EC75E9.2020608@redhat.com>
Date: Wed, 23 Aug 2006 11:36:09 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060801)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Robert Szentmihalyi <robert.szentmihalyi@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Group limit for NFS exported file systems
References: <20060823091652.235230@gmx.net> <p73u043656n.fsf@verdi.suse.de>
In-Reply-To: <p73u043656n.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> "Robert Szentmihalyi" <robert.szentmihalyi@gmx.de> writes:
>
>   
>> is there a group limit for NFS exported file systems in recent kernels?
>> One if my users cannot access directories that belong to a group he actually _is_ a member of. That, however, is true only when accessing them over NFS. On the local file system, everything is fine. UIDs and GIDs are the same on client and server, so that cannot be the problem. Client and server run Gentoo Linux with kernel 2.6.16 on the server and 2.6.17 on the client.
>>     
>
> NFSv2 has a 8 groups limit in the protocol iirc.

Ahh, no.  None of the NFS protocols define anything about the authentication
protocols.  This is defined by the RPC protocol and it defines a limit of 16
for AUTH_SYS, otherwise known as AUTH_UNIX.

Interestingly, the original NFSv2 implementations had a limit of 8, then 10,
and then finally 16.

    Thanx...

       ps
