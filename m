Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316604AbSEUVQY>; Tue, 21 May 2002 17:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316607AbSEUVQX>; Tue, 21 May 2002 17:16:23 -0400
Received: from air-2.osdl.org ([65.201.151.6]:11651 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S316604AbSEUVQW>;
	Tue, 21 May 2002 17:16:22 -0400
Date: Tue, 21 May 2002 14:16:14 -0700
From: Bob Miller <rem@osdl.org>
To: Ron Niles <Ron.Niles@falconstor.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Oops from local semaphore race condition
Message-ID: <20020521141614.A13087@doc.pdx.osdl.net>
In-Reply-To: <E79B8AB303080F4096068F046CD1D89B934D5E@exchange1.FalconStor.Net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2002 at 03:41:19PM -0400, Ron Niles wrote:
> 
> 
> Ron.Niles@falconstor.com said:
> >> Then I realized it can possibly go corrupt, due to a race condition
> >> which lets down() continue before up() is complete:
> 
> From: David Woodhouse [mailto:dwmw2@infradead.org]
> 
> >This is what completions were added for.
> 
> Thanks, struct completion is the best way; it's gonna be tough to maintain
> backward compatibility though.
> 
> One comment; it looks like the implementation in sched.c should more
> properly be using wq_write_lock_irqsave on the lock.
> 
I sent patches to Linus to fix this back in February.  Dave Jones picked
them up and they are still in his tree.  I don't know when/if he is going
to forward them onto Linus for inclusion into his tree.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
