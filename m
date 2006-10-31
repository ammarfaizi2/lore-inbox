Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946087AbWJaWqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946087AbWJaWqX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 17:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946092AbWJaWqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 17:46:23 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:63343 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1946087AbWJaWqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 17:46:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=fDFHLk37oa2fHx4Hhl0SrdP8l0AXAhcDuqwEtj3YWFN4uYF984P9H9yaTsV99vj75oc56+chXoFVqA5UvaI7DjLSvmhaMqSKli8ID1SUgsbYO7dHXuDpxiT+EPZ1Ur+DFB4C9lRIThnPD3PWxAvgsxgkToseQ94lXIb9g+Tov9k=  ;
Message-ID: <4547D23A.3090007@yahoo.com.au>
Date: Wed, 01 Nov 2006 09:46:18 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Borislav Petkov <petkov@math.uni-muenster.de>,
       David Rientjes <rientjes@cs.washington.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched.c : correct comment for this_rq_lock() routine
References: <Pine.LNX.4.64.0610301600550.12811@localhost.localdomain> <Pine.LNX.4.64N.0610301308290.17544@attu2.cs.washington.edu> <Pine.LNX.4.64.0610301623360.13169@localhost.localdomain> <20061031153021.GA14505@gollum.tnic> <Pine.LNX.4.64.0610311250500.22528@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0610311250500.22528@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote:

>example, i was just poking around the source for the various
>"atomic.h" files and noticed a couple possible cleanups:
>
>  1) make sure *everyone* uses "volatile" in the typedef struct (which
>	i actually submitted recently)
>

I don't see why. There is nothing in atomic (eg. atomic_read) that says
there must be a compiler barrier around the operation.

Have you checked that the architecture implementation actually needs the
volatile where you've added it?

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
