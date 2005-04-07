Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262386AbVDGCWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbVDGCWT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 22:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbVDGCWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 22:22:19 -0400
Received: from outmail1.freedom2surf.net ([194.106.33.237]:17886 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S262386AbVDGCWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 22:22:16 -0400
Message-ID: <4254994B.5090308@f2s.com>
Date: Thu, 07 Apr 2005 03:22:03 +0100
From: Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] freepgt2: arm26 FIRST_USER_ADDRESS PAGE_SIZE
References: <Pine.LNX.4.61.0504070204390.24723@goblin.wat.veritas.com> <Pine.LNX.4.61.0504070214490.24723@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0504070214490.24723@goblin.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> ARM26 define FIRST_USER_ADDRESS as PAGE_SIZE (beyond the machine vectors
> when they are mapped low), and use that definition in place of locally
> defined MIN_MAP_ADDR.  Previously, ARM26 permitted user mappings at 0 if
> the machine vectors were mapped high; but that's inconsistent with ARM,
> and FIRST_USER_ADDRESS would then have to be determined at runtime.
> Let's fix it at PAGE_SIZE throughout the architecture.

This is correct because ARM26 cant map vectors high at all.

applied.

