Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSEMQ3e>; Mon, 13 May 2002 12:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314223AbSEMQ3d>; Mon, 13 May 2002 12:29:33 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:3056 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S314138AbSEMQ3b>; Mon, 13 May 2002 12:29:31 -0400
Subject: Re: [PATCHSET] Linux 2.4.19-pre8-jam2
From: Robert Love <rml@tech9.net>
To: rwhron@earthlink.net
Cc: jamagallon@able.es, linux-kernel@vger.kernel.org
In-Reply-To: <20020513074514.A25499@rushmore>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 May 2002 09:29:28 -0700
Message-Id: <1021307368.18800.2586.camel@summit>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-05-13 at 04:45, rwhron@earthlink.net wrote:
> > - Re-introduction of wake_up_sync to make pipes run fast again. No idea
> >  about this is useful or not, that is the point, to test it (Randy ?)
> 
> Thanks, I was hoping someone would port that patch to a 2.4 kernel.
> 2.5 kernels <= 2.5.15 aren't completing umount on the 4 way Xeon.
> I will benchmark the latest jam on the big box next.
> 
> http://home.earthlink.net/~rwhron/kernel/bigbox.html

Is umount not completing somehow due to the lack of wake_up_sync ???

Fwiw, I am not sold that reintroducing wake_up_sync is worth it.  The
benchmark is synthetic and could very well not represent the general
case in which the load balancer is capable of handling the scenario
without the hackery of an explicit sync option.

	Robert Love

