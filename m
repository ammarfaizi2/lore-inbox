Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265248AbUGLRVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbUGLRVK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 13:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266892AbUGLRVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 13:21:10 -0400
Received: from rzfoobar.is-asp.com ([217.11.194.155]:4561 "EHLO mail.isg.de")
	by vger.kernel.org with ESMTP id S265248AbUGLRVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 13:21:07 -0400
Message-ID: <40F2C882.7070406@isg.de>
Date: Mon, 12 Jul 2004 19:21:06 +0200
From: Lutz Vieweg <lkv@isg.de>
Organization: Innovative Software AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040322 wamcom.org
X-Accept-Language: de, German, en
MIME-Version: 1.0
To: Michael Clark <michael@metaparadigm.com>
Cc: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: How to find out which pages were copied-on-write?
References: <40EACC0C.6060606@isg.de> <20040709113125.GA8897@lnx-holt.americas.sgi.com> <40EF0346.4040407@isg.de> <40EFA4C8.1050409@metaparadigm.com>
In-Reply-To: <40EFA4C8.1050409@metaparadigm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Clark wrote:
> HPAs library LPSM sounds like what you're looking for.
> 
> http://freshmeat.net/projects/lpsm/
> 
> Or you can do what you want the hard way using mprotect and a SEGV handler.

Certainly a valid idea to consider - doing all those things in userspace... so
thanks for the hint!

But wouldn't that introduce a significant overhead and undermine all of the
nice advantages the kernel might have in scheduling I/O operations?

However, I shall really consider and profile the mprotect/sighandler approach...

Regards,

Lutz Vieweg

PS: I'm using my own allocator already, so using the C-library implementation
     wouldn't gain me much...


