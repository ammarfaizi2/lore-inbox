Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264361AbRFGIEA>; Thu, 7 Jun 2001 04:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264360AbRFGIDr>; Thu, 7 Jun 2001 04:03:47 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52524 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S264361AbRFGIDa>; Thu, 7 Jun 2001 04:03:30 -0400
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Derek Glidden <dglidden@illusionary.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <Pine.LNX.4.33.0106070926400.6078-100000@mikeg.weiden.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Jun 2001 01:59:44 -0600
In-Reply-To: <Pine.LNX.4.33.0106070926400.6078-100000@mikeg.weiden.de>
Message-ID: <m1y9r44t5b.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <mikeg@wen-online.de> writes:

> On 7 Jun 2001, Eric W. Biederman wrote:
> 
> > Does this improve the swapoff speed or just allow other programs to
> > run at the same time?  If it is still slow under that kind of load it
> > would be interesting to know what is taking up all time.
> >
> > If it is no longer slow a patch should be made and sent to Linus.
> 
> No, it only cures the freeze.  The other appears to be the slow code
> pointed out by Andrew Morton being tickled by dead swap pages.

O.k.  I think I'm ready to nominate the dead swap pages for the big
2.4.x VM bug award.  So we are burning cpu cycles in sys_swapoff
instead of being IO bound?  Just wanting to understand this the cheap way :)

Eric
