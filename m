Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbVH3MOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbVH3MOb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 08:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbVH3MOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 08:14:31 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:43769 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751400AbVH3MOa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 08:14:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MBV0I6u7AbUZoxfjXRZ25thka8gZz8B9EzLmeDO4M+khaYdpyXckJu2+UwbVDKidNTNP6cKIL/r/wXBbHAounMb6qns6+1TKz7y8rVxYqvxDm+begoVbty1dEFr6UwSafghJN6JFIgJRd1HReQ/xMx3GVyAmwaIDZPcovUbqllo=
Message-ID: <9a8748490508300514414410b5@mail.gmail.com>
Date: Tue, 30 Aug 2005 14:14:30 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: zhang yuanyi <zhangyuanyi@gmail.com>
Subject: Re: What about adding range support for u32 classifier?
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-kernel@vger.kernel.org
In-Reply-To: <21c563b6050829202372189527@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <21c563b6050829202372189527@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/05, zhang yuanyi <zhangyuanyi@gmail.com> wrote:
> Hello, everyone!
> 
> The "range support" may be puzzled, but I don't know how to express my
> problem exactly because of my poor english.
> 
> Just take an example, I may need all udp packets received on eth0
> which source port is greater than 53 going into flow 10:1,  and I only
> wanna to type one tc command like this(In fact, I communicated with
> kernel directly):
> 
>     tc filter add dev eth0 parent ffff: protocol ip prio 20 \
>                                   u32 match udp sport gt 53 0xffff \
>                                         match ip protocol 17 0xff\
>                                    flowid 10:1
> 
> But I found I can't, because u32 classifier doesn't support matching
> multi-value in one key.So I need to add (65535-53) keys to a u32
> filter to implement this.
> 
> I intend to solve this problem by modifying u32 filter to match
> multi-value in one key, but I am worrying the preformance.
> 
> Can someone give me some suggestions?
> 
How is this a kernel problem?
"tc" is a userspace app. I think you'd be better off talking to Alexey
Kuznetsov (added to Cc), who wrote tc, about this.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
