Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135590AbRDXNFj>; Tue, 24 Apr 2001 09:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135591AbRDXNF2>; Tue, 24 Apr 2001 09:05:28 -0400
Received: from goat.cs.wisc.edu ([128.105.166.42]:17420 "EHLO goat.cs.wisc.edu")
	by vger.kernel.org with ESMTP id <S135590AbRDXNFS>;
	Tue, 24 Apr 2001 09:05:18 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: BUG: Global FPU corruption in 2.2
From: Victor Zandy <zandy@cs.wisc.edu>
Date: 24 Apr 2001 08:05:15 -0500
In-Reply-To: alad@hss.hns.com's message of "Tue, 24 Apr 2001 11:03:19 +0530"
Message-ID: <cpxu23etpmc.fsf@goat.cs.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Someone else here traced the process flags of a FP-intensive program
on a machine before and after it is put in the faulty FPU state.  He
periodically sampled /proc/pid/stat while the program was running.

He found that PF_USEDFPU was always set before the machine was broken.
After he found that it was set about 70% of the time.

Vic



