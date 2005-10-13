Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbVJMMjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbVJMMjJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 08:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbVJMMjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 08:39:08 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:60349 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751007AbVJMMjH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 08:39:07 -0400
Message-ID: <434E5574.8060901@de.ibm.com>
Date: Thu, 13 Oct 2005 14:39:16 +0200
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: carsteno@de.ibm.com
Organization: IBM Deutschland
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/21] mm: xip_unmap ZERO_PAGE fix
References: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com> <Pine.LNX.4.61.0510130218580.4343@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0510130218580.4343@goblin.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> Small fix to the PageReserved patch: the mips ZERO_PAGE(address) depends
> on address, so __xip_unmap is wrong to initialize page with that before
> address is initialized; and in fact must re-evaluate it each iteration.
Looks fine to me. I never realized they have multiple zero pages on mips.
--

Carsten Otte
IBM Linux technology center
ARCH=s390
