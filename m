Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265766AbTFSOmo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 10:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265781AbTFSOmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 10:42:44 -0400
Received: from lightning.hereintown.net ([141.157.132.3]:33466 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id S265766AbTFSOmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 10:42:39 -0400
Message-ID: <3EF1C978.6050502@hereintown.net>
Date: Thu, 19 Jun 2003 10:32:24 -0400
From: Chris Meadors <twrchris@hereintown.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030603
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make gcc3.3 Eliminate Unused Static Functions
References: <20030619135800.6D4514F01@gherkin.frus.com>
In-Reply-To: <20030619135800.6D4514F01@gherkin.frus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19T0q7-0003TL-1m*RsCpPbjQbrs*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Tracy wrote:

> Another data point...  Earlier (I *think* it was this thread) someone
> mentioned problems with trying to build glibc with gcc 3.x and "ls"
> segfaulting.  I've recently upgraded portions of my system (including
> libraries and compilers) with the packages from the Slackware 9.0 CD.
> I expect a certain amount of pain (due to library version conflicts)
> every time I go through the upgrade process, but this time the pain
> feels different...  I absolutely cannot get getty and uugetty from the
> getty-ps-2.1.0 package to work: segmentation faults.  Even tried building
> from source: no good.  My old getty and uugetty binaries (version 2.0.7j)
> seem to work ok with the new libraries, but rebuilding the 2.0.7j code
> with gcc-3.2.2 results in segfaults.

That was me, but it wasn't this thread.  I was talking about building
glibc against the 2.5.x kernel headers, that caused problems.  glibc
2.3.2 with gcc 3.3 against the 2.4.20 headers is perfectly stable, and
passes all tests in "make check".  Even with "-O3 -march=athlon-xp
-mfpmath=sse", the only tests that fail are in the trig functions (SSE
on the Althon only has 32 bit precision so the values are truncated).

-- 
Chris


