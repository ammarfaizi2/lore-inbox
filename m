Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbVLMPAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbVLMPAc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 10:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbVLMPAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 10:00:31 -0500
Received: from zrtps0kp.nortelnetworks.com ([47.140.192.56]:4312 "EHLO
	zrtps0kp.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S964985AbVLMPAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 10:00:30 -0500
Message-ID: <439EE1E9.9050203@nortel.com>
Date: Tue, 13 Dec 2005 08:59:53 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: David Howells <dhowells@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <1134479118.11732.14.camel@localhost.localdomain>	 <dhowells1134431145@warthog.cambridge.redhat.com>	 <3874.1134480759@warthog.cambridge.redhat.com>	 <439EDC3D.5040808@nortel.com> <1134485062.9814.0.camel@laptopd505.fenrus.org>
In-Reply-To: <1134485062.9814.0.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Dec 2005 14:59:56.0550 (UTC) FILETIME=[E183AA60:01C5FFF5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Tue, 2005-12-13 at 08:35 -0600, Christopher Friesen wrote:

>>In this case, introducing a new API means the changes can be made over time.
> 
> 
> in this case, doing this change gradual I think is a mistake. We should
> do all of the in-kernel code at least... 

This means verifying all the users before patch submission, which may be 
problematic.

I guess the point I'm trying to make is that if you create a new API you 
have the option of converting the obvious cases first, which should 
cover the majority of users.  Anywhere the behaviour is non-obvious can 
be left using the old API, and the out-of-tree users will continue to 
work correctly.

Chris
