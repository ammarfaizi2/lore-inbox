Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293163AbSBWRwh>; Sat, 23 Feb 2002 12:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293165AbSBWRw2>; Sat, 23 Feb 2002 12:52:28 -0500
Received: from mail.cogenit.fr ([195.68.53.173]:64144 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S293163AbSBWRwN>;
	Sat, 23 Feb 2002 12:52:13 -0500
Date: Sat, 23 Feb 2002 18:52:09 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Dan Aloni <da-x@gmx.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] C exceptions in kernel
Message-ID: <20020223185209.A7839@fafner.intra.cogenit.fr>
In-Reply-To: <1014412325.1074.36.camel@callisto.yi.org> <20020223162100.A1952@outpost.ds9a.nl> <1014480355.1844.16.camel@callisto.yi.org> <20020223082211.Z11156@work.bitmover.com> <1014483618.3085.37.camel@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1014483618.3085.37.camel@callisto.yi.org>; from da-x@gmx.net on Sat, Feb 23, 2002 at 07:00:16PM +0200
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Aloni <da-x@gmx.net> :
[...]
> 	cleanup {
> 		if (foo) free(foo);
                ^^
> 		if (bar) free(bar);
                ^^
                    
> 		if (locked) unlock();
                ^^
> 	}  
> 	return rc;
> }
> 
> Looks much better, IMHO.
> 
> The cleanup() block will run after the try block even if an exception 
> did not occur, and will run also if the exception occured, passing the
> exception to the next catch() or cleanup() block in stack.

Three useless "if" if no exception occured.

-- 
Ueimor
