Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030648AbVIBCRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030648AbVIBCRQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 22:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030649AbVIBCRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 22:17:16 -0400
Received: from mx1.suse.de ([195.135.220.2]:49096 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030648AbVIBCRP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 22:17:15 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
Date: Fri, 2 Sep 2005 04:17:10 +0200
User-Agent: KMail/1.8
Cc: Hiro Yoshioka <hyoshiok@miraclelinux.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
References: <20050825.135420.640917643.hyoshiok@miraclelinux.com> <20050902.104359.26944961.hyoshiok@miraclelinux.com> <20050901190846.479229cf.akpm@osdl.org>
In-Reply-To: <20050901190846.479229cf.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509020417.10574.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 September 2005 04:08, Andrew Morton wrote:

> I suppose I'll queue it up in -mm for a while, although I'm a bit dubious
> about the whole idea...  We'll gain some and we'll lose some - how do we
> know it's a net gain?

I suspect it'll gain more than it loses. The only case where it might 
not gain is immediately someone reading the data from the page cache again
after the write. But I suppose that's far less frequent than writing the data.

-Andi
