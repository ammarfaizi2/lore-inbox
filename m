Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWAZAMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWAZAMV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 19:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWAZAMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 19:12:20 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:34786 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751261AbWAZAMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 19:12:19 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: Rationale for RLIMIT_MEMLOCK?
To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       schilling@fokus.fraunhofer.de, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, tytso@mit.edu, arjan@infradead.org
Reply-To: 7eggert@gmx.de
Date: Thu, 26 Jan 2006 01:12:15 +0100
References: <5yddh-1pA-47@gated-at.bofh.it> <5ydni-1Qq-3@gated-at.bofh.it> <5yek1-3iP-53@gated-at.bofh.it> <5yeth-3us-33@gated-at.bofh.it> <5yf5O-4iF-19@gated-at.bofh.it> <5yfI4-5kU-11@gated-at.bofh.it> <5ygDT-6LK-3@gated-at.bofh.it> <5yscc-68j-5@gated-at.bofh.it> <5ysvk-6JI-5@gated-at.bofh.it> <5ysvk-6JI-3@gated-at.bofh.it> <5yEn7-7Or-21@gated-at.bofh.it> <5yUUI-6JR-15@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1F1ukJ-0002DA-LK@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:

> I could add this piece of code to the euid == 0 part of cdrecord:
> 
> LOCAL void
> raise_memlock()
> { 
> #ifdef  RLIMIT_MEMLOCK
>         struct rlimit rlim;
>  
>         rlim.rlim_cur = rlim.rlim_max = RLIM_INFINITY;

I think you should rather use the size you're going to mlock, or at least
the upper bound.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
