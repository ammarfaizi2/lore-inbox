Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbSKOBP3>; Thu, 14 Nov 2002 20:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265457AbSKOBP3>; Thu, 14 Nov 2002 20:15:29 -0500
Received: from holomorphy.com ([66.224.33.161]:61643 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265446AbSKOBP2>;
	Thu, 14 Nov 2002 20:15:28 -0500
Date: Thu, 14 Nov 2002 17:19:47 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Tim Hockin <thockin@sun.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH 1/2] Remove NGROUPS hardlimit (resend w/o qsort)
Message-ID: <20021115011947.GP23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Tim Hockin <thockin@sun.com>, Pete Zaitcev <zaitcev@redhat.com>,
	linux-kernel@vger.kernel.org
References: <mailman.1037316781.6599.linux-kernel2news@redhat.com> <200211150006.gAF06JF01621@devserv.devel.redhat.com> <3DD43C65.80103@sun.com> <20021114193156.A2801@devserv.devel.redhat.com> <3DD443EC.2080504@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD443EC.2080504@sun.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 04:46:36PM -0800, Tim Hockin wrote:
> Offer an alternative?  :)  Linked list costs us as much or MORE for 
> ->next as the gid_t.  kmalloc() doesn't work for previous reasoning.  I 
> considered a list of gid arr[256] or similar.  A voice reminds me that 
> it doesn't impact us noticably in real use.  Now, maybe other 
> architectures will find a good reason to switch to kmalloc() list of 
> smaller arrays, and the associated complextities or something else more 
> clever.

Well, there are always B-trees; nice low arrival rates to the allocator
owing to elements/node and O(lg(n)) searches with low constants due to
big fat branching factors. Not my call though.


Bill
