Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292344AbSBPK1I>; Sat, 16 Feb 2002 05:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292351AbSBPK06>; Sat, 16 Feb 2002 05:26:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59406 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292344AbSBPK0r>;
	Sat, 16 Feb 2002 05:26:47 -0500
Message-ID: <3C6E33AE.70504986@zip.com.au>
Date: Sat, 16 Feb 2002 02:25:50 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] get_request starvation fix
In-Reply-To: <3C69A196.B7325DC2@zip.com.au> <Pine.LNX.4.21.0202151515020.23069-100000@freak.distro.conectiva> <3C6E0B09.30983B1A@zip.com.au>,
		<3C6E0B09.30983B1A@zip.com.au> <E16c1qk-0002qM-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On February 16, 2002 08:32 am, Andrew Morton wrote:
> > However, contrary to my earlier guess, the request batching does
> > make a measurable difference.  Changing the code so that we wake up
> > a sleeper as soon as any request is freed costs maybe 30%
> > on `dbench 64'.
> 
> Is this consistent with results on other IO benchmarks?
> 

I dunno.  I doubt it - few of the other benchmarks are very
seek-intensive.   dbench is somewhat repeatable if you load
it up with enough clients.  And average the results across
enough runs.  And stand on one leg and squint.
