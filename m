Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264397AbTKZXmL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 18:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264399AbTKZXmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 18:42:11 -0500
Received: from evrtwa1-ar2-4-35-049-074.evrtwa1.dsl-verizon.net ([4.35.49.74]:58240
	"EHLO grok.yi.org") by vger.kernel.org with ESMTP id S264397AbTKZXmF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 18:42:05 -0500
Message-ID: <3FC53A40.8010904@candelatech.com>
Date: Wed, 26 Nov 2003 15:41:52 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Fire Engine??
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com.suse.lists.linux.kernel>	<20031125183035.1c17185a.davem@redhat.com.suse.lists.linux.kernel>	<p73fzgbzca6.fsf@verdi.suse.de>	<20031126113040.3b774360.davem@redhat.com>	<3FC505F4.2010006@google.com>	<20031126120316.3ee1d251.davem@redhat.com>	<20031126232909.7e8a028f.ak@suse.de>	<20031126143620.5229fb1f.davem@redhat.com>	<20031126235641.36fd71c1.ak@suse.de> <20031126151352.160b4734.davem@redhat.com>
In-Reply-To: <20031126151352.160b4734.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Wed, 26 Nov 2003 23:56:41 +0100
> Andi Kleen <ak@suse.de> wrote:
> 
> 
>>On Wed, 26 Nov 2003 14:36:20 -0800
>>"David S. Miller" <davem@redhat.com> wrote:
>>
>>
>>>I don't think this is acceptable.  It's important that all
>>>of the timestamps are as accurate as they were before.
>>
>>I disagree on that. The window is small and slowing down 99.99999% of all 
>>users who never care about this for this extremely obscure
>>misdesigned API does not make  much sense to me.
> 
> 
> We can't change behavior like this.  Every time we've tried to
> do it, we've been burnt.  Remember nonlocal-bind?

I'll try to write up a patch that uses the TSC and lazy conversion
to timeval as soon as I get the rx-all and rx-fcs code happily
into the kernel....

Assuming TSC is very fast and the conversion is accurate enough, I think
this can give good results....

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


