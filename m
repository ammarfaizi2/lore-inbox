Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318113AbSIAV4t>; Sun, 1 Sep 2002 17:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318117AbSIAV4s>; Sun, 1 Sep 2002 17:56:48 -0400
Received: from dsl-213-023-021-067.arcor-ip.net ([213.23.21.67]:53377 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318113AbSIAV4s>;
	Sun, 1 Sep 2002 17:56:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: statm_pgd_range() sucks!
Date: Mon, 2 Sep 2002 00:02:38 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@surriel.com
References: <20020830015814.GN18114@holomorphy.com> <3D6EDDC0.F9ADC015@zip.com.au>
In-Reply-To: <3D6EDDC0.F9ADC015@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17lcnn-0004cP-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 August 2002 04:51, Andrew Morton wrote:
> William Lee Irwin III wrote:
> > (1) shared, lib, text, & total are now reported as what's mapped
> >         instead of what's resident. This actually fixes two bugs:
> 
> hmm.  Personally, I've never believed, or even bothered to try to
> understand what those columns are measuring.  Does anyone actually
> find them useful for anything?  If so, what are they being used for?
> What info do we really, actually want to know?

I don't know what use 'shared' is, but it's clearly not very accurate
since it's just adding up all pages with count >= 1.  The only remotely
correct thing to do here is check for multiple pte reverse pointers.

-- 
Daniel
