Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131477AbRDSRLp>; Thu, 19 Apr 2001 13:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131497AbRDSRLg>; Thu, 19 Apr 2001 13:11:36 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:26704 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131477AbRDSRLX>; Thu, 19 Apr 2001 13:11:23 -0400
Date: Thu, 19 Apr 2001 19:33:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Takanori Kawano <t-kawano@ebina.hitachi.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel panics on raw I/O stress test
Message-ID: <20010419193322.F752@athlon.random>
In-Reply-To: <20010419210153Z.t-kawano@ebina.hitachi.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010419210153Z.t-kawano@ebina.hitachi.co.jp>; from t-kawano@ebina.hitachi.co.jp on Thu, Apr 19, 2001 at 09:01:53PM +0900
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 09:01:53PM +0900, Takanori Kawano wrote:
> 
> When I ran raw I/O SCSI read/write test with 2.4.1 kernel 
> on our IA64 8way SMP box, kernel paniced and following 
> message was displayed.

Could you try again with 2.4.4pre4 plus the below patch?

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.4pre2/rawio-3

You should experience also a quite noticeable improvement on both CPU usage and
disk I/O (also depends on the max size of a I/O request for your hardware disk
controller).

Andrea
