Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbTEGC3L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 22:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbTEGC3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 22:29:11 -0400
Received: from holomorphy.com ([66.224.33.161]:34188 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262371AbTEGC3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 22:29:10 -0400
Date: Tue, 6 May 2003 19:41:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@digeo.com>, dipankar@in.ibm.com,
       linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       paulus@samba.org
Subject: Re: [PATCH] kmalloc_percpu
Message-ID: <20030507024135.GW8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Andrew Morton <akpm@digeo.com>, dipankar@in.ibm.com,
	linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	paulus@samba.org
References: <20030506014745.02508f0d.akpm@digeo.com> <20030507023126.12F702C019@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030507023126.12F702C019@lists.samba.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 11:57:13AM +1000, Rusty Russell wrote:
> Paul Mackerras points out that we could get the numa-aware allocation
> plus "one big alloc" properties by playing with page mappings: reserve
> 1MB of virtual address, and map more pages as required.  I didn't
> think that we'd need that yet, though.

This is somewhat painful to do (though possible) on i386. The cost of
task migration would increase at the very least.


-- wli
