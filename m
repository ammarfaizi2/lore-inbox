Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267699AbUHJULz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267699AbUHJULz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 16:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267701AbUHJULy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 16:11:54 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:51033 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S267700AbUHJUKp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 16:10:45 -0400
Date: Tue, 10 Aug 2004 22:12:52 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Benno <benjl@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use posix headers in sumversion.c
Message-ID: <20040810201252.GA17828@mars.ravnborg.org>
Mail-Followup-To: Benno <benjl@cse.unsw.edu.au>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040810134102.GA15576@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810134102.GA15576@cse.unsw.edu.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 11:41:02PM +1000, Benno wrote:
> When compiling Linux on Mac OSX I had trouble with scripts/sumversion.c.
> It includes <netinet/in.h> to obtain to definitions of htonl and ntohl.
> 
> On Mac OSX these are found in <arpa/inet.h>. After checking the POSIX
> specification it appears that this is the correct place to get
> the definitons for these functions.
> 
> (http://www.opengroup.org/onlinepubs/009695399/functions/htonl.html)
> 
> Using this header also appears to work on Linux (at least with
> Glibc-2.3.2).
> 
> It seems clearer to me to go with the POSIX standard than implementing
> #if __APPLE__ style macros, but if such an approach is preferred I can
> supply patches for that instead.
> 
> A patch against 2.6.7 which change <netinet/in.h> -> <arpa/inet.h> is
> attached.
Your patch was reverse...
I fixed up fixdep.c as well.

Thanks,
	Sam
