Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265480AbSKOAjo>; Thu, 14 Nov 2002 19:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265484AbSKOAjo>; Thu, 14 Nov 2002 19:39:44 -0500
Received: from pheriche.sun.com ([192.18.98.34]:13292 "EHLO pheriche.sun.com")
	by vger.kernel.org with ESMTP id <S265480AbSKOAjn>;
	Thu, 14 Nov 2002 19:39:43 -0500
Message-ID: <3DD443EC.2080504@sun.com>
Date: Thu, 14 Nov 2002 16:46:36 -0800
From: Tim Hockin <thockin@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH 1/2] Remove NGROUPS hardlimit (resend w/o qsort)
References: <mailman.1037316781.6599.linux-kernel2news@redhat.com> <200211150006.gAF06JF01621@devserv.devel.redhat.com> <3DD43C65.80103@sun.com> <20021114193156.A2801@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:


> be about time to think about your data structures a little more.
> I'll let Andi to remind you about the performance impact (vmalloc
> area is outside of the big TLB area).

Offer an alternative?  :)  Linked list costs us as much or MORE for 
->next as the gid_t.  kmalloc() doesn't work for previous reasoning.  I 
considered a list of gid arr[256] or similar.  A voice reminds me that 
it doesn't impact us noticably in real use.  Now, maybe other 
architectures will find a good reason to switch to kmalloc() list of 
smaller arrays, and the associated complextities or something else more 
clever.

>>hmm, I haven't heard anything about them - can you offer an email or URL?

> http://www.uwsg.iu.edu/hypermail/linux/kernel/0010.0/0788.html

Thanks - will check it..


-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Linux Kernel Engineering
thockin@sun.com

