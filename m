Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbTJIOwV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 10:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbTJIOwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 10:52:21 -0400
Received: from colin2.muc.de ([193.149.48.15]:36873 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262188AbTJIOwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 10:52:20 -0400
Date: 9 Oct 2003 16:52:35 +0200
Date: Thu, 9 Oct 2003 16:52:35 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@muc.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       bos@serpentine.com
Subject: Re: [PATCH] Fix mlockall for PROT_NONE mappings
Message-ID: <20031009145235.GA47202@colin2.muc.de>
References: <20031009104218.GA1935@averell> <Pine.LNX.4.44.0310090743210.1694-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310090743210.1694-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 07:44:08AM -0700, Linus Torvalds wrote:
> 
> This is too ugly for words.
> 
> Just make mlockall() ignore any mappings that are not readable.

That is exactly what the patch is doing.

It has just to pass this information down to get_user_pages to make mlock() 
not ignore them too.

-Andi
