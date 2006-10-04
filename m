Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbWJDTgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbWJDTgs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 15:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWJDTgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 15:36:48 -0400
Received: from smtp-out.google.com ([216.239.45.12]:1973 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750912AbWJDTgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 15:36:47 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=YvCy/8UOJzEWbwFi8RYVigAV8Aj9MG2GyWvYl4RdWGwOpkJUSMO86csNkWgrKxrJE
	sEV69Qm4ULS9tr0nrGfyQ==
Message-ID: <45240D20.3080202@google.com>
Date: Wed, 04 Oct 2006 12:36:00 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sekharan@us.ibm.com
CC: Paul Menage <menage@google.com>, pj@sgi.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       winget@google.com, rohitseth@google.com, jlan@sgi.com,
       Joel.Becker@oracle.com, Simon.Derr@bull.net
Subject: Re: [RFC][PATCH 0/4] Generic container system
References: <20061002095319.865614000@menage.corp.google.com>	 <1159925752.24266.22.camel@linuxchandra>	 <6599ad830610031934s41994158o59f1a2e58b1cb45e@mail.gmail.com> <1159988217.24266.60.camel@linuxchandra>
In-Reply-To: <1159988217.24266.60.camel@linuxchandra>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>It would certainly be possible to have finer-grained locking. But the
>>cpuset code seems pretty happy with coarse-grained locking (only one
> 
> 
> cpuset may be happy today. But, It will not be happy when there are tens
> of other container subsystems use the same locks to protect their own
> data structures. Using such coarse locking will certainly affect the
> scalability.

All of this (and the rest of the snipped email with suggested
improvements) makes pretty good sense. But would it not be better
to do this in stages?

1) Split the code out from cpusets
2) Move to configfs
3) Work on locking scalability, etc ...

Else it'd seem that we'll never get anywhere, and it'll all be
impossible to review anyway. Incremental improvement would seem to
be a much easier way to fix this stuff, to me.

M.
