Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030271AbWCTVU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbWCTVU5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbWCTVU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:20:57 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:675 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030271AbWCTVU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:20:56 -0500
Date: Tue, 21 Mar 2006 08:20:37 +1100
From: Nathan Scott <nathans@sgi.com>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: xfs-masters@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: kill kmem_zone init
Message-ID: <20060321082037.A653275@wobbly.melbourne.sgi.com>
References: <Pine.LNX.4.58.0603201501540.18684@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.58.0603201501540.18684@sbz-30.cs.Helsinki.FI>; from penberg@cs.Helsinki.FI on Mon, Mar 20, 2006 at 03:04:14PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 03:04:14PM +0200, Pekka J Enberg wrote:
> Hi!

Hi Pekka,

> This patch changes kmem_zone_init() callers to use kmem_cache_alloc() so
> we can kill the wrapper.

Sorry, but thats just silly.  Did you even look at the code
around what you're changing (it has to do more than just wrap
up slab calls)?  So, NACK on this patch - it leaves the code
very confused (half zoney, half slaby), and is just unhelpful
code churn at the end of the day.

For your zalloc patch, you will need to duplicate the logic
in kmem_zone_alloc into kmem_zone_zalloc in order to use that
new zalloc interface you're introducing - which should be fine.

cheers.

-- 
Nathan
