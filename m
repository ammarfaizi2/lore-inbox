Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272561AbTHPCWs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 22:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272576AbTHPCWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 22:22:48 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:17098
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272561AbTHPCWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 22:22:47 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Timothy Miller <tim@techsource.com>
Subject: Re: [PATCH] O12.2int for interactivity
Date: Sat, 16 Aug 2003 12:29:03 +1000
User-Agent: KMail/1.5.3
Cc: Timothy Miller <miller@techsource.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
References: <20030804195058.GA8267@cray.fish.zetnet.co.uk> <200308160235.05105.kernel@kolivas.org> <3F3D23BD.6050608@techsource.com>
In-Reply-To: <3F3D23BD.6050608@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308161229.03334.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Aug 2003 04:17, Timothy Miller wrote:
> >All "nice" 0 tasks get the same size timeslice. If their dynamic priority
> > is different (the PRI column in top) they still get the same timeslice.
>
> Why isn't dynamic priority just an extension of static priority?  Why do
> you modify only the ordering while leaving the timeslice alone?

Because master engineer Molnar has determined that's the correct way.

> So, tell me if I infer this correctly:  If you have a nice 5 and a nice
> 7, but the nice 5 is a cpu hog, while the nice 7 is interactive, then
> the interactivity scheduler can modify their dynamic priorities so that
> the nice 7 is being run before the nice 5.  However, despite that, the
> nice 7 still gets a shorter timeslice than tha nice 5.
>
> Have you tried altering this?

Yes, not good with fluctuating timeslices all over the place makes for more 
bounce in the algorithm, and the big problem - the cpu intensive applications 
get demoted to smaller timeslices and they are the tasks that benefit the 
most from larger timeslices (for effective cpu cache usage).

Con

