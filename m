Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbTDKURk (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 16:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbTDKURk (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 16:17:40 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:29172 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S261682AbTDKURj (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 16:17:39 -0400
Message-ID: <3E9725C5.3090503@mvista.com>
Date: Fri, 11 Apr 2003 13:29:57 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Kevin P. Fleming" <kpfleming@cox.net>
CC: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com, greg@kroah.com
Subject: Re: [ANNOUNCE] udev 0.1 release
References: <20030411172011.GA1821@kroah.com> <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net>
In-Reply-To: <3E970A00.2050204@cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Kevin P. Fleming wrote:

>
> What happens if these secondary hotplug events occur while 
> /sbin/hotplug has not yet finished processing the first one? Ignoring 
> locking/race issues for the moment, I'm concerned about memory 
> consumption as many layers of hotplug/udev/kpartx/etc. are running 
> processing these events.

It gets even worse, because performance of hotswap events on disk adds 
is critical and spawning processes is incredibly slow compared to the 
performance required by some telecom applications...

A much better solution could be had by select()ing on a filehandle 
indicating when a new hotswap event is ready to be processed.  No races, 
no security issues, no performance issues.

>

