Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUATD6P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 22:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbUATD6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 22:58:15 -0500
Received: from mail.ccur.com ([208.248.32.212]:65033 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S263806AbUATD6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 22:58:11 -0500
Date: Mon, 19 Jan 2004 22:57:56 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Paul Jackson <pj@sgi.com>, akpm@osdl.org, paulus@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitmap parsing/printing routines, version 4
Message-ID: <20040120035756.GA15703@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20040114150331.02220d4d.pj@sgi.com> <20040115002703.GA20971@tsunami.ccur.com> <20040114204009.3dc4c225.pj@sgi.com> <20040115081533.63c61d7f.akpm@osdl.org> <20040115181525.GA31086@tsunami.ccur.com> <20040115161732.458159f5.pj@sgi.com> <400873EC.2000406@us.ibm.com> <20040117063618.GA14829@tsunami.ccur.com> <20040117183929.GA24185@tsunami.ccur.com> <400C4966.2030803@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400C4966.2030803@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 01:17:26PM -0800, Matthew Dobson wrote:
> Joe,
> 	I've attatched a small patch with some *small* changes, and the 
> addition of a whole lotta comments.  I'd like to see what you think.
> 
> Changes:
> 1) Added a missing '"' in the comment for the bitmap_parse function
> 2) Renamed 'oc' to 'old_c' for readability
> 3) Remove "totaldigits == 0" check at the end of bitmap_parse.  I 
> believe this check is redundant.  The only way that totaldigits could be 
> 0 at the end of the function is if ndigits is also 0 (because they're 
> both incremented at the same time), and this condition is already 
> checked for at the end of each chunk parsed.  Is this correct?
> 
> Additions:
> 4) A whole bunch of comments.  Are these all correct?
> 
> None of the things in my patch (with the possible exception of #3) 
> change the functionality of the code, which looks great.
> 
> Andrew, I agree with Paul's "thumbs-up" of Joe's patch.  My patch is 
> solely meant to increase the readability of the bitmap_parse function.
> 
> Cheers!
> 
> -Matt

Indeed you are correct, the final (totaldigits == 1) test can be removed.
Good catch.

However, IMHO you added too many comments.  Unlike Andrew, I do believe
one can have too many comments.  Comments become 'too many' when they
dilute to the point that the code can no longer be clearly read.

If you reduce the comments to just those that say something not easily
deduced from the code, then they would be acceptable to me, and would
make a useful addition IMO.  That would be all but three, or perhaps four,
of them.

Andrew, if you do like the fully commented version, then please remove
my name from the comment in the patch.  The dilute style of coding is
not one I wish to have my name associated with.

Thanks,
Joe
