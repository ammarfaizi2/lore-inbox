Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287003AbSBIAGS>; Fri, 8 Feb 2002 19:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287865AbSBIAGI>; Fri, 8 Feb 2002 19:06:08 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:2543
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S287003AbSBIAF4>; Fri, 8 Feb 2002 19:05:56 -0500
Date: Fri, 8 Feb 2002 16:05:33 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] New locking primitive for 2.5
Message-ID: <20020209000533.GA372@matchmail.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020208211628.GC343@mis-mike-wstn> <E16ZL4i-0005Ri-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16ZL4i-0005Ri-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2002 at 12:09:04AM +0000, Alan Cox wrote:
> > SMP 486s would need that (if there is such a beast).  What point does x86
> > get the 64 bit instructions?  If after 586, then it would definitely need a
> > spin-lock or some-such in those functions.
> 
> There are SMP 486 class x86 machines that are MP 1.1 compliant. They are
> sufficiently rare that I think its quite acceptable to "implement" a
> cmpxchg8b macro on 486 as spin_lock_irqsave/blah/spin_unlock_irqrestore. It
> would be wrong to cripple the other 99.99% of SMP users
> 

Sorry, I only meant to say that the only question is where the split should
be between spin-lock and 64bit instruction...

This would be included in the appropriate config option.

Mike
