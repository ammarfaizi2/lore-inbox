Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWIEHxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWIEHxQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 03:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWIEHxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 03:53:16 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:60835 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932151AbWIEHxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 03:53:15 -0400
Date: Tue, 5 Sep 2006 09:52:55 +0200
From: Voluspa <lista1@comhem.se>
To: Ingo Molnar <mingo@elte.hu>
Cc: akpm@osdl.org, arjan@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockdep: disable lock debugging when kernel state
 becomes untrusted
Message-Id: <20060905095255.349e684c.lista1@comhem.se>
In-Reply-To: <20060905071501.GA2765@elte.hu>
References: <20060814030954.c3a57e05.lista1@comhem.se>
	<20060813184159.b536736f.akpm@osdl.org>
	<20060905071501.GA2765@elte.hu>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.4.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Sep 2006 09:15:01 +0200 Ingo Molnar wrote:
> 
> * Andrew Morton wrote:
> 
> > That would appear to be a bug.  debug_locks_off() is running 
> > console_verbose() waaaay after the locking selftest code has 
> > completed.
> 
> debug_locks_off() should only be used when a real bug is being
> displayed 
> - which isnt the case when we call add_taint(). The patch below
> should fix this.

Thanks, it works as advertised.

Mvh
Mats Johannesson
