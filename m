Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbUCGF4d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 00:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbUCGF4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 00:56:33 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:55492 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261756AbUCGF4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 00:56:32 -0500
To: Peter Zaitsev <peter@mysql.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Any way to access huge pages ?
References: <1078636886.2313.718.camel@abyss.local>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 06 Mar 2004 21:56:31 -0800
In-Reply-To: <1078636886.2313.718.camel@abyss.local>
Message-ID: <523c8lw67k.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 07 Mar 2004 05:56:32.0021 (UTC) FILETIME=[F0D8DC50:01C40408]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Peter> Hello, I'm wondering is there any way to access "large
    Peter> pages" (4MB) memory other than using shared memory ?  For
    Peter> example can you do anonymous mmap to get access to large
    Peter> pages.

    Peter> I would like to utilize large pages for MySQL buffer pool
    Peter> and other large caches, but would not like to use Shared
    Peter> memory for this purpose as it will complicate things for
    Peter> users.

Does mmap() on hugetlbfs do what you want?  See
Documentation/vm/hugetlbpage.txt for details.

 - Roland
