Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbTKDWbR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 17:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbTKDWbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 17:31:17 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:16824
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S261190AbTKDWbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 17:31:15 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Chris Vine <chris@cvine.freeserve.co.uk>, Rik van Riel <riel@redhat.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Date: Wed, 5 Nov 2003 09:30:56 +1100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
References: <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com> <200311041355.08731.kernel@kolivas.org> <200311042208.05748.chris@cvine.freeserve.co.uk>
In-Reply-To: <200311042208.05748.chris@cvine.freeserve.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311050930.56909.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Nov 2003 09:08, Chris Vine wrote:
> Your diagnosis looks right, but two points -
>
> 1.  The test compile was not of the kernel but of a file in a C++ program
> using quite a lot of templates and therefore which is quite memory
> intensive (for the sake of choosing something, it was a compile of
> src/main.o in
> http://www.cvine.freeserve.co.uk/efax-gtk/efax-gtk-2.2.2.src.tgz).  It
> would be a sad day if the kernel could not be compiled under 2.6 in 32MB of
> memory, and I am glad to say that it does compile - my 2.6.0-test9 kernel
> compiles on the 32MB machine in on average 45 minutes 13 seconds under
> kernel 2.4.22, and in 54 minutes 11 seconds under 2.6.0-test9 with your
> latest patch, which is not an enormous difference.  (As a digression, in
> the 2.0 days the kernel would compile in 6 minutes on the machine in
> question, and at the time I was very impressed.)

Phew. It would be sad if it couldn't compile a kernel indeed.
>
> 2.  Being able to choose a manual setting for swappiness is not "futile". 
> As I mentioned in an earlier post, a swappiness of 10 will enable
> 2.6.0-test9 to compile the things I threw at it on a low end machine,
> albeit slowly, whereas with dynamic swappiness it would not compile at all.
>  So the difference is between being able to do something and not being able
> to do it.

I agree with you on that; I meant it would be futile trying to get the compile 
times back to 2.4 levels with just this tunable modified alone (statically or 
dynamically)... which means we should look elsewhere for ways to tackle this.

Con

