Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWIRQ3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWIRQ3B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 12:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751831AbWIRQ3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 12:29:01 -0400
Received: from minus.inr.ac.ru ([194.67.69.97]:23942 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S1750977AbWIRQ3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 12:29:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=r7oMrGGWk4KCoJtOj/1La4e4/MNAcsQGlC6M/A2i5dAZpEiOejMel8/5NktRJXXo1tDhMf5D97/1ind5/05vGhg0chGJxwnSJ5rxAO3WSVSjW+uCQGnHZUgWUVWp9KdUslhoxp4OZk+YeFuW61btNhD55kIllxxrYE9aR2DtD9E=;
Date: Mon, 18 Sep 2006 20:28:47 +0400
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: Andi Kleen <ak@suse.de>
Cc: "Vladimir B. Savkin" <master@sectorb.msk.ru>,
       Jesper Dangaard Brouer <hawk@diku.dk>,
       Harry Edmon <harry@atmos.washington.edu>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
Message-ID: <20060918162847.GA4863@ms2.inr.ac.ru>
References: <4492D5D3.4000303@atmos.washington.edu> <p73ac4x4doi.fsf@verdi.suse.de> <20060918153822.GA805@ms2.inr.ac.ru> <200609181754.37623.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609181754.37623.ak@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Hmm, not sure how that could happen. Also is it a real problem
> even if it could?

As I said, the problem is _occasionally_ theoretical.

This would happen f.e. if packet socket handler was installed
after IP handler. Then tcpdump would get packet after it is processed
(acked/replied/forwarded). This would be disasterous, the results
are unparsable.

I recall, the issue was discussed, and that time it looked more
reasonable to solve problems of this kind taking timestamp once
before it is seen by all the rest of stack. Who could expect that
PIT nightmare is going to return? :-)


> Then it has to use the ACPI pmtmr which is really really slow.
> The overhead of that thing is so large that you can clearly see it in
> the network benchmark.

I see. Thank you.

Alexey
