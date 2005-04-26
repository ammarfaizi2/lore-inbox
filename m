Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVDZUVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVDZUVJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 16:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVDZUVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 16:21:08 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:28570 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S261568AbVDZUTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 16:19:06 -0400
Message-ID: <426EA220.6010007@ammasso.com>
Date: Tue, 26 Apr 2005 15:18:40 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: Andrew Morton <akpm@osdl.org>, libor@topspin.com, hch@infradead.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs
 implementation
References: <20050425135401.65376ce0.akpm@osdl.org>	<521x8yv9vb.fsf@topspin.com> <20050425151459.1f5fb378.akpm@osdl.org>	<426D6D68.6040504@ammasso.com> <20050425153256.3850ee0a.akpm@osdl.org>	<52vf6atnn8.fsf@topspin.com> <20050425171145.2f0fd7f8.akpm@osdl.org>	<52acnmtmh6.fsf@topspin.com> <20050425173757.1dbab90b.akpm@osdl.org>	<52wtqpsgff.fsf@topspin.com> <20050426084234.A10366@topspin.com>	<52mzrlsflu.fsf@topspin.com> <20050426122850.44d06fa6.akpm@osdl.org> <5264y9s3bs.fsf@topspin.com>
In-Reply-To: <5264y9s3bs.fsf@topspin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:

> Yes, I agree.  If an app wants to register half a page and pass the
> other half to a child process, I think the only answer is "don't do
> that then."

How can the app know that, though?  It would have to allocate I/O buffers with knowledge 
of page boundaries.  Today, the apps just malloc() a bunch of memory and pay no attention 
to whether the beginning or the end of the buffer shares a page with some other, unrelated 
object.  We may as well tell the app that it needs to page-align all I/O buffers.

My point is that we can't just simply say, "Don't do that".  Some entity (the kernel, 
libraries, whatever) should be able to tell the app that its usage of memory is going to 
break in some unpredictable way.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
