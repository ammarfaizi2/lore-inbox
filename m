Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751824AbWGZX7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbWGZX7t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 19:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbWGZX7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 19:59:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61098 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751824AbWGZX7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 19:59:48 -0400
Date: Wed, 26 Jul 2006 19:59:31 -0400
From: Dave Jones <davej@redhat.com>
To: Dave Airlie <airlied@linux.ie>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] vm/agp: remove private page protection map
Message-ID: <20060726235931.GA5687@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dave Airlie <airlied@linux.ie>, Hugh Dickins <hugh@veritas.com>,
	Andrew Morton <akpm@osdl.org>, Dave Jones <davej@codemonkey.org.uk>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <Pine.LNX.4.64.0607181905140.26533@skynet.skynet.ie> <Pine.LNX.4.64.0607262135440.11629@blonde.wat.veritas.com> <Pine.LNX.4.64.0607270023120.23571@skynet.skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607270023120.23571@skynet.skynet.ie>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 12:24:27AM +0100, Dave Airlie wrote:
 > >
 > >I'm happy with the intent of your vm_get_page_prot() patch (and would
 > >like to extend it to other places after, minimizing references to the
 > >protection_map[]).  But there's a few aspects which distress me - the
 > >u8 type nowhere else in mm, the requirement that caller mask the arg,
 > >agp_convert_mmap_flags still using its own conversion from PROT_ to VM_
 > >while there's an inline in mm.h (though why someone thought to optimize
 > >and so obscure that version puzzles me!).  Would you be happy to insert
 > >your Sign-off in the replacement below?
 > 
 > No worries, I think davej can drop my one from his tree as well and take 
 > this..

Done, and pushed out to agpgart.git

Thanks,

		Dave

-- 
http://www.codemonkey.org.uk
