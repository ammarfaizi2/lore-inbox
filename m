Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261813AbRESO7Q>; Sat, 19 May 2001 10:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261821AbRESO7H>; Sat, 19 May 2001 10:59:07 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:23790 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261813AbRESO6t>;
	Sat, 19 May 2001 10:58:49 -0400
Date: Sat, 19 May 2001 10:58:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: bcrl@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]
 device arguments from lookup)
In-Reply-To: <UTC200105191419.QAA53656.aeb@vlet.cwi.nl>
Message-ID: <Pine.GSO.4.21.0105191051370.5339-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 May 2001 Andries.Brouwer@cwi.nl wrote:

> > A lot of stuff relies on the fact that close(open(foo, O_RDONLY))
> > is a no-op. Breaking that assumption is a Bad Thing(tm).
> 
> Also here I would like to agree. Unfortunately this is false.
> Opening device files often has interesting side effects.

Too bad. They can be triggered by similar races between attacker
changing the type of object (file<->symlink) and backup.

