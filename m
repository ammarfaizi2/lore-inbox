Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbTE3Dob (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 23:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263234AbTE3Dob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 23:44:31 -0400
Received: from rth.ninka.net ([216.101.162.244]:61064 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263219AbTE3Doa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 23:44:30 -0400
Subject: Re: Algoritmic Complexity Attacks and 2.4.20 the dcache code
From: "David S. Miller" <davem@redhat.com>
To: Scott A Crosby <scrosby@cs.rice.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <oydbrxlbi2o.fsf@bert.cs.rice.edu>
References: <oydbrxlbi2o.fsf@bert.cs.rice.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054267067.2713.3.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 May 2003 20:57:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-29 at 13:42, Scott A Crosby wrote:
> I highly advise using a universal hashing library, either our own or
> someone elses. As is historically seen, it is very easy to make silly
> mistakes when attempting to implement your own 'secure' algorithm.

Why are you recommending this when after 2 days of going back
and forth in emails with me you came to the conclusion that for
performance critical paths such as the hashes in the kernel the Jenkins
hash was an acceptable choice?

It is unacceptably costly to use a universal hash, it makes a multiply
operation for every byte of key input plus a modulo operation at the
end of the hash computation.  All of which can be extremely expensive
on some architectures.

I showed and backed this up for you with benchmarks comparing your
universal hashing code and Jenkins.

Some embedded folks will have your head on a platter if we end up using
a universal hash function for the DCACHE solely based upon your advice.
:-)

-- 
David S. Miller <davem@redhat.com>
