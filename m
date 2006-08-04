Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030276AbWHDBbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbWHDBbW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 21:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbWHDBbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 21:31:22 -0400
Received: from smtp-out.google.com ([216.239.45.12]:11756 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030276AbWHDBbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 21:31:22 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=rod3/+Z8hxhDLo0peTTh8qhwEoeFsJr/cpb47DkKCOlJd/RWnxV8gSPRPl8zuSfmK
	cex6jv1dhPfsJ/+vz0CqA==
Message-ID: <44D2A357.6020108@google.com>
Date: Thu, 03 Aug 2006 18:31:03 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Nate Diller <nate.diller@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] [2/2] Add the Elevator I/O scheduler
References: <5c49b0ed0608031603v5ff6208bo63847513bee1b038@mail.gmail.com> <20060803235304.GB7265@redhat.com>
In-Reply-To: <20060803235304.GB7265@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
>  > +#define ops_count(el, req) ((el)->ops[req->flags & REQ_RW ? 1 : 0])
>  > +#define sec_count(el, req) ((el)->sec[req->flags & REQ_RW ? 1 : 0])
>  > +#define sweep_latency(el, req) ((el)->sweep_latency[(req)->flags &
>  > REQ_RW ? 1 : 0])
> 
> You like your macros huh ? :)

That is, can they please be inline functions.

Regards,

Daniel
