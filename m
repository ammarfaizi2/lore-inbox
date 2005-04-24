Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbVDXVxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbVDXVxM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 17:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbVDXVxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 17:53:12 -0400
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:44542 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262450AbVDXVxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 17:53:09 -0400
Message-ID: <426C151F.3000407@ammasso.com>
Date: Sun, 24 Apr 2005 16:52:31 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, hch@infradead.org, roland@topspin.com,
       hozer@hozed.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
References: <20050411163342.GE26127@kalmia.hozed.org> <5264yt1cbu.fsf@topspin.com> <20050411180107.GF26127@kalmia.hozed.org> <52oeclyyw3.fsf@topspin.com> <20050411171347.7e05859f.akpm@osdl.org> <4263DEC5.5080909@ammasso.com> <20050418164316.GA27697@infradead.org> <4263E445.8000605@ammasso.com> <20050423194421.4f0d6612.akpm@osdl.org> <426BABF4.3050205@ammasso.com> <20050424205309.GA5386@kroah.com>
In-Reply-To: <20050424205309.GA5386@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> You don't "support" i386 or ia64 or x86-64 or ppc64 systems?  What
> hardware do you support? 

I've never seen or heard of any x86-32 or x86-64 system that supports hot-swap RAM. Our 
hardware does not support PPC, and our software doesn't support ia-64.

 > And what about the fact that you are aiming to
> get this code into mainline, right?  If not, why are you asking here?
> :)

Well, our primary concern is getting our stuff to work.  Since get_user_pages() doesn't 
work, but mlock() does, that's what we use.  I don't know how to fix get_user_pages(), and 
I don't have the time right now to figure it out.  I know that technically mlock() is not 
the right way to do it, and so we're not going to be submitting our code for the mainline 
until get_user_pages() works and our code uses it instead of mlock().

