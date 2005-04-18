Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbVDRQut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbVDRQut (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 12:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVDRQut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 12:50:49 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:55707 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S262125AbVDRQun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 12:50:43 -0400
Message-ID: <4263E53E.3090107@ammasso.com>
Date: Mon, 18 Apr 2005 11:50:06 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: Troy Benjegerdes <hozer@hozed.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>	<20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com>	<4263DBBF.9040801@ammasso.com> <52is2kawsi.fsf@topspin.com>
In-Reply-To: <52is2kawsi.fsf@topspin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>     Timur> Why do you call mlock() and get_user_pages()?  In our code,
>     Timur> we only call mlock(), and the memory is pinned.  We have a
>     Timur> test case that fails if only get_user_pages() is called,
>     Timur> but it passes if only mlock() is called.
> 
> What if a buggy/malicious userspace program doesn't call mlock()?

Our library calls mlock() when the apps requests memory to be "registered".  We then call 
munlock() when the app requests the memory to be unregistered.  All apps talk to our 
library for all services.  No apps talk to the driver directly.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com
