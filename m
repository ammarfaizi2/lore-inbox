Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311132AbSCHVRq>; Fri, 8 Mar 2002 16:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311134AbSCHVRg>; Fri, 8 Mar 2002 16:17:36 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:21398 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311132AbSCHVRR>; Fri, 8 Mar 2002 16:17:17 -0500
Date: Fri, 08 Mar 2002 13:16:48 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Samuel Ortiz <sortiz@dbear.engr.sgi.com>
cc: Andrea Arcangeli <andrea@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] stop null ptr deference in __alloc_pages
Message-ID: <18990000.1015622208@flay>
In-Reply-To: <12160000.1015620577@flay>
In-Reply-To: <Pine.LNX.4.33.0203081207360.18968-100000@dbear.engr.sgi.com> <12160000.1015620577@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> If you applied an SGI patch that makes the zonelist contain all the zones
>> of your machine, then the zonelist should not be NULL.
>> If you allocate memory with gfp_mask & GFP_ZONEMASK == GFP_NORMAL from a
>> HIGHMEM only node, then the first entry on the corresponding zonelist
>> should be the first NORMAL zone on some other node.
>> Am I missing something here ?
> 
> You're missing the fact that I'm missing the SGI patch ;-)

I should have also mentioned that:

1) I shouldn't need the SGI patch, though it might help performance.
2) The kernel panics without my fix, and runs fine with it.

M.

