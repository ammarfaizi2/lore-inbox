Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274904AbTHFHkf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 03:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274905AbTHFHke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 03:40:34 -0400
Received: from CPE-144-132-162-109.nsw.bigpond.net.au ([144.132.162.109]:61934
	"EHLO tigers-lfs.local") by vger.kernel.org with ESMTP
	id S274904AbTHFHka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 03:40:30 -0400
Date: Wed, 6 Aug 2003 17:39:50 +1000
From: Greg Schafer <gschafer@zip.com.au>
To: OSDL <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2 oops - NPTL triggered
Message-ID: <20030806073950.GA1896@tigers-lfs.nsw.bigpond.net.au>
References: <20030806021316.GA408@tigers-lfs.nsw.bigpond.net.au> <200308060523.h765NII31787@mail.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308060523.h765NII31787@mail.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 10:23:18PM -0700, OSDL wrote:
> It looks like the list poisoning triggers:
> 
>         ecx: 00200200 edx: 00100100
> 
> those are the poison values for the prev/next fields of lists (see
> <linux/list.h>).
> 
> So it looks like switch_exec_pids() is removing a list entry that was
> already removed.

Indeed. FWIW, a newer compiler gave the same results. This is way beyond my
debugging skills but I can reliably reproduce and am willing to test
anything you can suggest.

Greg
