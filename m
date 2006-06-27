Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030606AbWF0Byn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030606AbWF0Byn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 21:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030607AbWF0Byn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 21:54:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:52570 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030606AbWF0Bym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 21:54:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T8N/swQGz+urHkM3YEZYfaS755bWF58qBKvKZukHSFOycO4nXcFM9MBYzNXXjz7pTXxEaZLr5XVAaLm/6P3W53cBM7Rys+fQzEu6I7zmDUhyACe2ADIdl5SA8jpOKGQy6MZUhBy9cpJl95z/BANymgjTBCVZSDXuVkhIeNPis1A=
Message-ID: <6d6a94c50606261854o2a179b5aw2b6e91b074a9d60e@mail.gmail.com>
Date: Tue, 27 Jun 2006 09:54:40 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] Fix kernel BUGs when enable SLOB allocator
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44A01D14.5060708@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d6a94c50606260551n666a62d0ue578ce3c70fae1@mail.gmail.com>
	 <44A01D14.5060708@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

We are using SLOB allocator, why need to set PageSlab?
If later there come forth another type of allocator(SLEB, SLUB), Do we
still need to set PageSlab bit?

On the other hand, I'm not sure if the current SLOB code works
properly on the MMU system. If so, I think changing the nommu.c should
be a better solution.

Regards,
-Aubrey

On 6/27/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Then what if objp isn't a slob object?
>
> I think the better fix would be to make slob set PageSlab.
>
> --
> SUSE Labs, Novell Inc.
> Send instant messages to your online friends http://au.messenger.yahoo.com
>
>
