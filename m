Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290306AbSAPAoR>; Tue, 15 Jan 2002 19:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290305AbSAPAoB>; Tue, 15 Jan 2002 19:44:01 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:57362 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S290303AbSAPAnR>; Tue, 15 Jan 2002 19:43:17 -0500
Date: Tue, 15 Jan 2002 19:43:16 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: John Weber <weber@nyc.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.5.3-pre1 compile error
Message-ID: <20020115194316.I17477@redhat.com>
In-Reply-To: <20020115192048.G17477@redhat.com> <Pine.LNX.4.33.0201151628440.1140-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0201151628440.1140-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jan 15, 2002 at 04:29:38PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 04:29:38PM -0800, Linus Torvalds wrote:
> > +#ifndef __ASM__ATOMIC_H
> > +#include <asm/atomic.h>
> > +#endif
> 
> Please do not assume knowdledge of what the different header files use to
> define their re-entrancy.

Well, I actually disagree on this.  For large include files (fs.h is the 
worst), and complicated arrangement, this technique eliminates spurious 
includes and saves a lot on compile time (really!).  If your concern is 
that the convention is not consistent, I'll gladly patch all of them to 
use the same format (ie use an __ prefix and escape / to __ and . to _).

		-ben
