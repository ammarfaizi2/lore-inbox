Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318144AbSHKTG7>; Sun, 11 Aug 2002 15:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318199AbSHKTG7>; Sun, 11 Aug 2002 15:06:59 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:29940 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318144AbSHKTG6>; Sun, 11 Aug 2002 15:06:58 -0400
Subject: Re: large page patch (fwd) (fwd)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Phillips <phillips@arcor.de>
Cc: frankeh@watson.ibm.com, davidm@hpl.hp.com,
       David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, gh@us.ibm.com,
       Martin.Bligh@us.ibm.com, wli@holomorpy.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <E17dBZN-0001Ng-00@starship>
References: <Pine.LNX.4.44.0208031240270.9758-100000@home.transmeta.com>
	<15692.37018.693984.745251@napali.hpl.hp.com>
	<200208041319.05210.frankeh@watson.ibm.com>  <E17dBZN-0001Ng-00@starship>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 11 Aug 2002 21:30:17 +0100
Message-Id: <1029097817.16421.53.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-09 at 16:20, Daniel Phillips wrote:
> On Sunday 04 August 2002 19:19, Hubertus Franke wrote:
> > "General Purpose Operating System Support for Multiple Page Sizes"
> > htpp://www.usenix.org/publications/library/proceedings/usenix98/full_papers/ganapathy/ganapathy.pdf
> 
> This reference describes roughly what I had in mind for active 
> defragmentation, which depends on reverse mapping.  The main additional
> wrinkle I'd contemplated is introducing a new ZONE_LARGE, and GPF_LARGE,
> which means the caller promises not to pin the allocation unit for long
> periods and does not mind if the underlying physical page changes
> spontaneously.  Defragmenting in this zone is straightforward.

Slight problem. This paper is about a patented SGI method for handling
defragmentation into large pages (6,182,089). They patented it before
the presentation.

They also hold patents on the other stuff that you've recently been
discussing about not keeping seperate rmap structures until there are
more than some value 'n' when they switch from direct to indirect lists
of reverse mappings (6,112,286)

If you are going read and propose things you find on Usenix at least
check what the authors policies on patents are.

Perhaps someone should first of all ask SGI to give the Linux community
permission to use it in a GPL'd operating system ?


