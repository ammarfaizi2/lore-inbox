Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265740AbUGDPuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265740AbUGDPuq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 11:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265747AbUGDPuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 11:50:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29884 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265740AbUGDPum
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 11:50:42 -0400
Message-ID: <40E82744.3030203@pobox.com>
Date: Sun, 04 Jul 2004 11:50:28 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Linville <linville@redhat.com>
CC: linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: i810_audio MMIO patch
References: <200406301956.i5UJu6mp007649@savage.devel.redhat.com>
In-Reply-To: <200406301956.i5UJu6mp007649@savage.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Linville wrote:
> Attached is a second patch to account for (most of) Herbert Xu's
> comments.
> 
> I have left-out the part about changing state->card to a
> local variable where it is used a lot.  Unfortunately, that usage is
> somewhat pervasive and I would prefer to make those changes in a separate
> patch -- after I have had a chance to do some testing.
> 
> If you'd prefer one patch to account for the original plus these
> changes, let me know and I'll be happy to provide it.

I forwarded this and the main patch to Andrew, for some testing -mm. 
Then push it upstream.

The main thing you did not address of Herbert's comments was the macro 
naming, AFAICS.  I don't have a big preference.  If asked, my style 
preference for this driver would be

ICH_R8
ICH_R16
ICH_R32
ICH_W8
ICH_W16
ICH_W32

Short, and bit-size-explicit.

I've always been annoyed that the API function 'readl' represented 32 
bits :)

	Jeff



