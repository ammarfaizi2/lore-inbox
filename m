Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261258AbSJHRgs>; Tue, 8 Oct 2002 13:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261274AbSJHRgs>; Tue, 8 Oct 2002 13:36:48 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:30428 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261258AbSJHRgs>; Tue, 8 Oct 2002 13:36:48 -0400
Date: Tue, 08 Oct 2002 10:38:17 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: might_sleep warning in both 41 and 41-mm1
Message-ID: <568740000.1034098697@flay>
In-Reply-To: <3DA31468.E0E4F711@digeo.com>
References: <1455194388.1034066565@[10.10.2.3]> <3DA31468.E0E4F711@digeo.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Oh.  It seems that the pte mapping functions will run inc_preempt_count()
> via kmap_atomic() even if CONFIG_HIGHPTE=n.  So the ifdef around
> page_table_present() needs to be CONFIG_HIGHMEM.  Or we don't use
> kmap_atomic() at all in the pte mapping functions.
> 
> Please tell me that you had CONFIG_HIGHPTE=n?

Yes. Highpte was off.

Thanks ;-)

M.
