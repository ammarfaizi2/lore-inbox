Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286521AbSCFXbp>; Wed, 6 Mar 2002 18:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286959AbSCFXbg>; Wed, 6 Mar 2002 18:31:36 -0500
Received: from dsl-213-023-043-059.arcor-ip.net ([213.23.43.59]:34987 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S286521AbSCFXbU>;
	Wed, 6 Mar 2002 18:31:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: [RFC] Arch option to touch newly allocated pages
Date: Thu, 7 Mar 2002 00:26:24 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Jeff Dike <jdike@karaya.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <3C84F449.8090404@zytor.com> <E16ikc5-00032P-00@starship.berlin> <20020306182026.F866@redhat.com>
In-Reply-To: <20020306182026.F866@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16ikng-00032Z-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 7, 2002 12:20 am, Benjamin LaHaise wrote:
> On Thu, Mar 07, 2002 at 12:14:15AM +0100, Daniel Phillips wrote:
> > On March 6, 2002 05:36 pm, Benjamin LaHaise wrote:
> > > On Wed, Mar 06, 2002 at 04:24:17PM +0100, Daniel Phillips wrote:
> > > > On March 6, 2002 04:24 pm, Benjamin LaHaise wrote:
> > > > > On Wed, Mar 06, 2002 at 03:59:22PM +0100, Daniel Phillips wrote:
> > > > > > Suppose you have 512 MB memory and an equal amount of swap.  You start 8
> > > > > > umls with 64 MB each.  With your and Peter's suggestion, the system always
> > > > > > goes into swap.  Whereas if the memory is only allocated on demand it
> > > > > > probably doesn't.
> > > > > 
> > > > > As I said previously, going into swap is preferable over randomly killing 
> > > > > new tasks under heavy load.
> > > > 
> > > > Huh?  In the example I gave, you will never oom but with your suggestion, you
> > > > will always go needlessly go into swap.  I'm suprised that you and Peter are
> > > > aguing in favor of wasting resources.
> > > 
> > > I'm arguing in favour of predictable behaviour.  Stability and reliability 
> > > are more important than a bit of swap space.
> > 
> > That's the same argument that says memory overcommit should not be allowed.
> 
> Go back in the thread: I suggested making it an option that the user has to 
> turn on to allow his foot to be shot.  Remember: the common case in the kernel 
> is to be using all memory.

OK, now suppose the user has turned on that option (I think it should be on by
default, like memory overcommit).  How is Jeff going to support it?  That's his
whole point as I understand it.

Instead of providing constructive suggestions on how to solve the problem so that
memory overcommit works properly in this case, I see people telling Jeff there is
no problem.  I think Jeff has a little more of a clue than that.
 
-- 
Daniel
