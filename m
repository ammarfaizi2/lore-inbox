Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265563AbSJXRbZ>; Thu, 24 Oct 2002 13:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265564AbSJXRbZ>; Thu, 24 Oct 2002 13:31:25 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:10765
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S265563AbSJXRbZ>; Thu, 24 Oct 2002 13:31:25 -0400
Subject: Re: [CFT] faster athlon/duron memory copy implementation
From: Robert Love <rml@tech9.net>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com
In-Reply-To: <3DB82ABF.8030706@colorfullife.com>
References: <3DB82ABF.8030706@colorfullife.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 24 Oct 2002 13:37:34 -0400
Message-Id: <1035481054.735.52.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-24 at 13:15, Manfred Spraul wrote:

> Attached is a test app that compares several memory copy implementations.
> Could you run it and report the results to me, together with cpu, 
> chipset and memory type?

Hi Manfred.  Below is the average of three runs.

Dual Athlon 1600, AMD 760M chipset, 2GB of ECC DDR266.

Looks like AMD is right :)

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 18622 cycles per page
copy_page function '2.4 non MMX'         took 21086 cycles per page
copy_page function '2.4 MMX fallback'    took 21096 cycles per page
copy_page function '2.4 MMX version'     took 18498 cycles per page
copy_page function 'faster_copy'         took 10311 cycles per page
copy_page function 'even_faster'         took 10464 cycles per page
copy_page function 'no_prefetch'         took 8589 cycles per page

	Robert Love

