Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbULRTPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbULRTPQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 14:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbULRTPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 14:15:16 -0500
Received: from main.gmane.org ([80.91.229.2]:24992 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261216AbULRTPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 14:15:10 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Joseph Seigh" <jseigh_02@xemaps.com>
Subject: Re: What does atomic_read actually do?
Date: Sat, 18 Dec 2004 14:20:44 -0500
Message-ID: <opsi7xcuizs29e3l@grunion>
References: <opsi7o5nqfs29e3l@grunion> <1103394867.4127.18.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.ne.client2.attbi.com
User-Agent: Opera M2/7.54 (Win32, build 3865)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Dec 2004 19:34:27 +0100, Arjan van de Ven <arjan@infradead.org>  
wrote:

> On Sat, 2004-12-18 at 11:23 -0500, Joseph Seigh wrote:
>> It doesn't do anything that would actually guarantee that the fetch from
>> memory would be atomic as far as I can see, at least in the x86 version.
>
> define atomic....
>
> what linux atomics guarantee you is that you either "see" the old or the
> new value if you use atomic_* as the sole accessor API, with the
> footnote that this only holds if you don't forcefully misalign the
> atomic_t.
>
> if you want ordering guarantees on top... you need to use explicit
> bariers for that (wmb/rmb and friends).
>
> For the "no inbetween" rule, doing the read the way x86 does works on
> x86, since x86 makes sure that on the write side, no intermediate
> results become visible.

I mean atomic in the either old or new sense.  I'm wondering what  
guarantees
the atomicity.  Not the C standard.  I can see the gcc compiler uses a MOV
instruction to load the atomic_t from memory which is guaranteed atomic by
the architecture if aligned properly.  But gcc does that for any old int
as far as I can see, so why use atomic_read?

Joe Seigh

