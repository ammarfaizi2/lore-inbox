Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265648AbTFSA2t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 20:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265654AbTFSA2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 20:28:49 -0400
Received: from fed1mtao05.cox.net ([68.6.19.126]:1982 "EHLO fed1mtao05.cox.net")
	by vger.kernel.org with ESMTP id S265648AbTFSA2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 20:28:47 -0400
Message-ID: <3EF10705.9090609@cox.net>
Date: Wed, 18 Jun 2003 17:42:45 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5a) Gecko/20030603
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Oliver Neukum <oliver@neukum.org>, Robert Love <rml@tech9.net>,
       Patrick Mochel <mochel@osdl.org>, Andrew Morton <akpm@digeo.com>,
       sdake@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
References: <3EE8D038.7090600@mvista.com> <1055459762.662.336.camel@localhost> <20030612232523.GA1917@kroah.com> <200306132201.47346.oliver@neukum.org> <20030618225913.GB2413@kroah.com> <3EF10002.7020308@cox.net> <20030619002039.GA2866@kroah.com>
In-Reply-To: <20030619002039.GA2866@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> But you also have to "hold" events for a bit of time in order to
> determine that things are out of order, or we have a gap.  So a bit of
> "complex" logic is in the works, but it's much less complex than if we
> didn't have that sequence number.
> 

OK, so the important point here is that while you probably delay events 
for a small amount of time (1-3 seconds maybe) to ensure that you aren't 
processing steps out of order, it's not likely that userspace is going 
hold event #1321 for an indefinite period of time just because it has 
never seen event #1320.

I can't wait to see this implementation; it's going to be interesting, 
to say the least. However, without the sequence numbers, it would very 
likely be impossible.

