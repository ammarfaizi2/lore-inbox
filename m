Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272065AbRISVqt>; Wed, 19 Sep 2001 17:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272718AbRISVqj>; Wed, 19 Sep 2001 17:46:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30550 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S272065AbRISVq3>; Wed, 19 Sep 2001 17:46:29 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: phillips@bonn-fries.net (Daniel Phillips),
        rfuller@nsisoftware.com (Rob Fuller), linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <E15jnIB-0003gh-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Sep 2001 15:37:26 -0600
In-Reply-To: <E15jnIB-0003gh-00@the-village.bc.nu>
Message-ID: <m1elp2g8vd.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > On September 17, 2001 06:03 pm, Eric W. Biederman wrote:
> > > In linux we have avoided reverse maps (unlike the BSD's) which tends
> > > to make the common case fast at the expense of making it more
> > > difficult to handle times when the VM system is under extreme load and
> > > we are swapping etc.
> > 
> > What do you suppose is the cost of the reverse map?  I get the impression you
> 
> > think it's more expensive than it is.
> 
> We can keep the typical page table cost lower than now (including reverse
> maps) just by doing some common sense small cleanups to get the page struct
> down to 48 bytes on x86

While there is a size cost I suspect you will notice reverse maps
a lot more in operations like fork where having them tripples the amount
of memory that you need to copy.  So you should see a double or more
in the time it takes to do a fork.

That I think is a significant cost.

Eric

