Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318211AbSHBFVA>; Fri, 2 Aug 2002 01:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318216AbSHBFVA>; Fri, 2 Aug 2002 01:21:00 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:58048 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S318211AbSHBFU7>;
	Fri, 2 Aug 2002 01:20:59 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15690.6005.624237.902152@napali.hpl.hp.com>
Date: Thu, 1 Aug 2002 22:24:05 -0700
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Rik van Riel <riel@conectiva.com.br>, "David S. Miller" <davem@redhat.com>,
       Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, rohit.seth@intel.com, sunil.saxena@intel.com,
       asit.k.mallick@intel.com
Subject: Re: large page patch 
In-Reply-To: <E17aSCT-0008I0-00@w-gerrit2>
References: <Pine.LNX.4.44L.0208012246390.23404-100000@imladris.surriel.com>
	<E17aSCT-0008I0-00@w-gerrit2>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 01 Aug 2002 19:29:52 -0700, Gerrit Huizenga <gh@us.ibm.com> said:

  Gerrit> It would sure be nice if the interface wasn't some kludgey
  Gerrit> back door but more integrated with things like mmap() or
  Gerrit> shm*(), with semantics and behaviors that were roughly more
  Gerrit> predictable.  Other than that, no comments as yet on the
  Gerrit> patch internals...

In my opinion the proposed large-page patch addresses a relatively
pressing need for databases (primarily).  Longer term, I'd hope that
it can be replaced by a transparent superpage scheme.  But the
existing patch can also serve as a nice benchmark for transparent
schemes (and frankly, since it doesn't have to do anything smart
behind the scenes, it's likely that the existing patch, where
applicable, will always do slightly better than a transparent one).

In any case, the big issue of physical memory fragmentation can be
experimented with indepent what the user-level interface looks like.
So the existing patch is useful in that sense as well.

	--david
