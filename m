Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289677AbSA2Mar>; Tue, 29 Jan 2002 07:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289589AbSA2M3f>; Tue, 29 Jan 2002 07:29:35 -0500
Received: from dsl-213-023-043-145.arcor-ip.net ([213.23.43.145]:47235 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289653AbSA2M3C>;
	Tue, 29 Jan 2002 07:29:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Helge Hafting <helgehaf@aitel.hist.no>, Momchil Velikov <velco@fadata.bg>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Note describing poor dcache utilization under high memory pressure
Date: Tue, 29 Jan 2002 13:33:57 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.44.0201281918050.18405-100000@waste.org> <87g04pfr8y.fsf@fadata.bg> <3C568D6D.ACDEA36C@aitel.hist.no>
In-Reply-To: <3C568D6D.ACDEA36C@aitel.hist.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VXSX-0000AD-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 29, 2002 12:54 pm, Helge Hafting wrote:
> Momchil Velikov wrote:
> > 
> > >>>>> "Daniel" == Daniel Phillips <phillips@bonn-fries.net> writes:
> [...]
> > Daniel> It's only touching the ptes on tables that are actually used, so if a parent
> > Daniel> with a massive amount of mapped memory forks a child that only instantiates
> > Daniel> a small portion of it (common situation) then the saving is pretty big.
> > 
> > Umm, all the ptes af the parent ought to be made COW, no ?
> 
> Sure. But quite a few of them may be COW already, if the parent 
> itself is a result of some earlier fork.

Right, or if the parent has already forked at least one child.

-- 
Daniel
