Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267580AbUHEHHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267580AbUHEHHq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 03:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267581AbUHEHHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 03:07:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26292 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267580AbUHEHHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 03:07:44 -0400
Message-ID: <4111DC8C.7050504@redhat.com>
Date: Thu, 05 Aug 2004 00:06:52 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       linux-kernel@vger.kernel.org, robustmutexes@lists.osdl.org,
       Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>,
       Jamie Lokier <jamie@shareable.org>
Subject: Re: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
References: <F989B1573A3A644BAB3920FBECA4D25A6EC06D@orsmsx407> <20040804232123.3906dab6.akpm@osdl.org>
In-Reply-To: <20040804232123.3906dab6.akpm@osdl.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> This fixes what appear to be some fairly significant shortcomings.  What do
> the futex and NPTL people have to say about the gravity of the problems
> which this solves, and the offered implementation?

This code will not be suppoerted by the glibc code.  Using these
primitives would mean significant slowdown of all operations and this
for problems which only a few people have.  I asked to get the useful
parts of the code to be made available using the current futex interface
(robust mutexes are useful) but Inaky and rest rest never acted on this
and instead invented this completely incompatible interface.  IMO this
code should not go into the mainstream kernel.  Let those who want to do
realtime work bear the costs.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
