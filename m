Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVAaV0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVAaV0Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 16:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVAaV0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 16:26:24 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:1251 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S261362AbVAaV0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 16:26:22 -0500
Message-ID: <41FEA27B.90508@candelatech.com>
Date: Mon, 31 Jan 2005 13:26:19 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: close-exec flag not working in 2.6.9?
References: <41FDE497.6040308@candelatech.com> <a36005b505013113084015a85@mail.gmail.com>
In-Reply-To: <a36005b505013113084015a85@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> On Sun, 30 Jan 2005 23:56:07 -0800, Ben Greear <greearb@candelatech.com> wrote:
> 
>>   flags = fcntl(s, F_GETFL);
>>   flags |= (FD_CLOEXEC);
>>   if (fcntl(s, F_SETFL, flags) < 0) {
> 
> 
> These have to be F_GETFD and F_SETFD respectively.  Note L -> D.

Yes, that does seem to work much better.  It would have been
a while before I ever figured that out on my own.

Thanks to you and the other people who pointed that out
off the list!

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

