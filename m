Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275619AbTHOBq3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 21:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275637AbTHOBq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 21:46:29 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:27667 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S275619AbTHOBq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 21:46:28 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Date: Fri, 15 Aug 2003 01:45:45 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <bhhe09$hve$1@abraham.cs.berkeley.edu>
References: <20030809173329.GU31810@waste.org> <20030814165320.GA2839@speare5-1-14> <bhgoj9$9ab$1@abraham.cs.berkeley.edu> <20030815001713.GD5333@speare5-1-14>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1060911945 18414 128.32.153.211 (15 Aug 2003 01:45:45 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Fri, 15 Aug 2003 01:45:45 +0000 (UTC)
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Val Henson  wrote:
>On Thu, Aug 14, 2003 at 07:40:25PM +0000, David Wagner wrote:
>> I don't see where you are getting this from.  Define
>>   F(x) = first80bits(SHA(x))
>>   G(x) = first80bits(SHA(x)) xor last80bits(SHA(x)).
>> What makes you think that F is a better (or worse) hash function than G?
>
>See Matt Mackall's earlier post on correlation, excerpted at the end
>of this message.  Basically, with two strings x and y, the entropy of
>x alone or y alone is always greater than or equal to the entropy of x
>xored with y.
>
>entropy(x) >= entropy(x xor y)
>entropy(y) >= entropy(x xor y)

Sorry; that's not accurate.  Here's a counterexample.  Let x and y be
two 80-bit strings.  Assume that x is either 0 or 1 (equal probability
for both possibilities).  Assume y is either 0 or 2 (equal probability
for both possibilities), and is independent of x.  Then
  entropy(x) = 1 bit
  entropy(y) = 1 bit
  entropy(x xor y) = 2 bits

The difference between F and G is very small, and there is not much
basis for choosing one over the other.
