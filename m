Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136284AbRECJPP>; Thu, 3 May 2001 05:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136290AbRECJPG>; Thu, 3 May 2001 05:15:06 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:3788 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S136284AbRECJOt>;
	Thu, 3 May 2001 05:14:49 -0400
Date: Thu, 3 May 2001 05:14:45 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: "Eric S. Raymond" <esr@thyrsus.com>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Why recovering from broken configs is too hard
In-Reply-To: <20010503104511.C754@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.GSO.4.21.0105030452310.15957-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 May 2001, Ingo Oeser wrote:

> But we only give this solution a certain amount of "tries" and
> give up (or tell the user, that we have a hard time here and aks
> for continue or abort and fixing by hand), if we either tried to
> often or a certain amount of time has passed (30secs maximum
> until next prompt).

Actually, I suspect that problem is much easier than Eric had described it.

Assertion: you can split the set of variables into disjoint union of
small subsets X, Y_1,...,Y_m such that each constraint is concerned
only with variables from X and at most one of Y_i.

IOW, there is a small "core" and for fixed values of core variables
constraints fall into groups, each dealing with its own _small_
set of variables.

If that assertion is true the complexity is nowhere near 3^N.

Eric, you probably have the most accurate information about the
existing constraints. Care to verify the assertion above? I'm
serious - the set of constraints is very far from generic and
if nothing else, such preprocessing (splitting variables into
core and peripherial groups) can make life easier in other
parts of the thing.

