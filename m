Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262843AbVA2Cuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262843AbVA2Cuu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 21:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262844AbVA2Cuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 21:50:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5840 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262843AbVA2Cun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 21:50:43 -0500
Date: Fri, 28 Jan 2005 21:50:27 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: John Richard Moser <nigelenki@comcast.net>
cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
In-Reply-To: <41F96C7D.9000506@comcast.net>
Message-ID: <Pine.LNX.4.61.0501282147090.19494@chimarrao.boston.redhat.com>
References: <20050127101117.GA9760@infradead.org>  <20050127101322.GE9760@infradead.org>
  <41F92721.1030903@comcast.net>  <1106848051.5624.110.camel@laptopd505.fenrus.org>
  <41F92D2B.4090302@comcast.net>  <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>
  <41F95F79.6080904@comcast.net> <1106862801.5624.145.camel@laptopd505.fenrus.org>
 <41F96C7D.9000506@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2005, John Richard Moser wrote:
> Arjan van de Ven wrote:

>>> Is this one any worse?
>> yes.
>>
>> oracle, db2 and similar like to mmap 2Gb or more *in one chunk*.
>
> Special case?

Absolutely, but ...

> Can I get this put into perspective?  How much more important is "Good"
> randomization versus "not breaking Oracle," which becomes "No
> randomization"

1) quite a lot of Linux users do use Oracle, DB2 or do
    scientific calculations - distributions cannot afford
    to break those applications, the default has to work
    for everybody

2) "weaker" randomization (2MB) is still effective if the
    stack is non-executable, so the "load a bunch of NOPs"
    approach won't work - this is what Fedora and RHEL use

3) it is not as theoretically strong as what you propose,
    but having the "weaker" scheme enabled is definitely
    more secure than having the "stronger" scheme disabled
    because it breaks applications

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
