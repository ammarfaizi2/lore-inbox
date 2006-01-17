Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWAQHDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWAQHDw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 02:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWAQHDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 02:03:52 -0500
Received: from 7ka-campus-gw.mipt.ru ([194.85.83.97]:30459 "EHLO
	7ka-campus-gw.mipt.ru") by vger.kernel.org with ESMTP
	id S1751227AbWAQHDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 02:03:51 -0500
Message-ID: <43CC96C7.7030103@sw.ru>
Date: Tue, 17 Jan 2006 10:03:35 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
References: <20060116223431.GA24841@suse.de>	<43CC2AF8.4050802@sw.ru>	<20060116232957.GA26342@suse.de> <20060116180529.45283133.akpm@osdl.org>
In-Reply-To: <20060116180529.45283133.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Olaf Hering <olh@suse.de> wrote:
>>  On Tue, Jan 17, Kirill Korotaev wrote:
>>
>>> Olaf, can you please check if my patch for busy inodes from -mm tree 
>>> helps you?
>> I cant reprpoduce it at will, thats the thing. It likely happens with NFS
>> mounts. agruen@suse.de did some work recently. But I remember even with
>> these changes (for a 2.6.13), the busy inodes did not disappear.
>>
>> Merging your patch into our cvs will give it more testing, I will do
>> that tomorrow if noone disagrees.
>>
> 
> The patch is certainly safe and stable.  But it's so huge and complex and
> ugly that I was hoping that a better fix would turn up.  The bug itself
> takes quite some ingenuity to hit.
We have another idea how to reimplement it via refcounters instead of 
lists. But I'm not sure when this will happen, due to lack of time :(

Kirill
