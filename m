Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbTE2KV7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 06:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTE2KV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 06:21:59 -0400
Received: from holomorphy.com ([66.224.33.161]:59782 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262114AbTE2KVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 06:21:55 -0400
Date: Thu, 29 May 2003 03:35:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Stewart Smith <stewartsmith@mac.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: buffer_head.b_bsize type
Message-ID: <20030529103503.GZ8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Stewart Smith <stewartsmith@mac.com>, linux-kernel@vger.kernel.org,
	trivial@rustcorp.com.au
References: <746529B0-91C0-11D7-9488-00039346F142@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <746529B0-91C0-11D7-9488-00039346F142@mac.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 08:29:40PM +1000, Stewart Smith wrote:
> The buffer_head structure (include/linux/buffer_head.h) uses a u32 type 
> while everywhere else (e.g. bread) the size parameter is of type int.
> Currently on all architectures u32 is defined as unsigned int. We 
> should probably not be doing unsigned and signed swaps. And you should 
> never really have a negative size of a buffer.
> So, there are two solutions: either change the buffer_head struct to be 
> int so it matches everywhere else, or change everywhere else.
> The attached patch does the change in one place. Although perhaps 
> changing everywhere else would be better. Thoughts? I'm happy to make 
> up the patch if needed.
> Applies cleanly to 2.5.69 and 2.5.70 and has been tested on i386 
> without causing any further problems (that I can see at least).

Could we go the other way and make all users of b_size use unsigned?


Thanks.


-- wli
