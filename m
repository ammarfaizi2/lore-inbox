Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVDRQKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVDRQKi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 12:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVDRQKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 12:10:38 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:58521 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S261372AbVDRQKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 12:10:33 -0400
Message-ID: <4263DBBF.9040801@ammasso.com>
Date: Mon, 18 Apr 2005 11:09:35 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: Troy Benjegerdes <hozer@hozed.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>	<20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com>
In-Reply-To: <52mzs51g5g.fsf@topspin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>     Troy> How is memory pinning handled? (I haven't had time to read
>     Troy> all the code, so please excuse my ignorance of something
>     Troy> obvious).
> 
> The userspace library calls mlock() and then the kernel does
> get_user_pages().

Why do you call mlock() and get_user_pages()?  In our code, we only call mlock(), and the 
memory is pinned.  We have a test case that fails if only get_user_pages() is called, but 
it passes if only mlock() is called.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com
