Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbVCRTBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVCRTBQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 14:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVCRTBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 14:01:15 -0500
Received: from smtp102.rog.mail.re2.yahoo.com ([206.190.36.80]:31164 "HELO
	smtp102.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261774AbVCRTBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 14:01:13 -0500
Subject: Re: 2.6.11 breaks modules gratuitously
From: John Kacur <jkacur@rogers.com>
Reply-To: jkacur@rogers.com
To: LKML <linux-kernel@vger.kernel.org>
Cc: Greg Stark <gsstark@mit.edu>, Jean Delvare <khali@linux-fr.org>,
       bunk@stusta.de
In-Reply-To: <20050318194915.580c3511.khali@linux-fr.org>
References: <3JrTO-1C4-41@gated-at.bofh.it>
	 <20050318194915.580c3511.khali@linux-fr.org>
Content-Type: text/plain
Message-Id: <1111172461.5993.10.camel@linux.site>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 18 Mar 2005 14:01:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-18 at 13:49, Jean Delvare wrote:
> Hi Greg,
> 
> > When you guys go on these "make needlessly global code static" kicks
> > you should maybe consider that even functions that aren't currently
> > used by any other area of the tree might be useful for module writers.
> > 
> > Instead of just checking which functions are currently used by other
> > parts of the kernel perhaps you should think about what makes a
> > logical API and stick to that, even if not all of the functions are
> > currently used.
> 
> I'd second that. Cleanups are good and I do not deny that Adrian Bunk
> has been doing a terrific work. However, unexporting or removing
> functions just because they have no current user in the kernel tree is
> not always a clever thing to do. Keeping things square and logical
> should be taken into consideration, as should the possibility that some
> function might be used outside of the kernel tree. I do *not* mean
> entire interfaces only used outside of the kernel tree, because these
> are highly questionable, but functions that are part of a larger set of
> functions representing an interface, most of which are used inside the
> kernel. In this specific case, dropping exports or removing functions
> make very little sense to me and is sometimes calling for trouble, as
> Greg just underlined. In some cases, the functions are likely to be
> reintroduced/reexported a few months later and we certainly could use
> our time in a more useful way than undoing and redoing things.
> 
> Thanks,

So perhaps we can introduce a new term to linux kernel development,
reexporting a symbol can now be known as debunking?

(sorry, sorry, I couldn't resist)

