Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWFMSV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWFMSV5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 14:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWFMSV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 14:21:57 -0400
Received: from [198.99.130.12] ([198.99.130.12]:5764 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932217AbWFMSV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 14:21:56 -0400
Date: Tue, 13 Jun 2006 14:21:29 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Alberto Bertogli <albertito@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [UML] Problems building and running 2.6.17-rc4 on x86-64
Message-ID: <20060613182129.GA4619@ccure.user-mode-linux.org>
References: <20060514182541.GA4980@gmail.com> <20060613145718.GB9729@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060613145718.GB9729@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2006 at 11:57:18AM -0300, Alberto Bertogli wrote:
> I just wanted to report that this went away when trying 2.6.17-rc6 as a
> host. It also works fine as a guest (after I patch it with
> http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.17-rc4/patches/jmpbuf
> so that it builds).
> 
> Besides, the random segfault problems I had with previous guests
> versions also seem to be fixed.

These two problems are related, and were both on the host.  Bodo
Stroesser reported a while ago that ptrace, by returning via sysret
rather than iret, could cause register corruption when tracing
sigreturn.

The UML crash seems to have been caused by the fix to that problem.

				Jeff
