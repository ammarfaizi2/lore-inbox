Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263753AbREYOEx>; Fri, 25 May 2001 10:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263755AbREYOEn>; Fri, 25 May 2001 10:04:43 -0400
Received: from [195.180.174.187] ([195.180.174.187]:1920 "EHLO idun.neukum.org")
	by vger.kernel.org with ESMTP id <S263754AbREYOEe>;
	Fri, 25 May 2001 10:04:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: Keith Owens <kaos@ocs.com.au>, Andreas Dilger <adilger@turbolinux.com>
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8
Date: Fri, 25 May 2001 16:03:57 +0200
X-Mailer: KMail [version 1.2]
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <24688.990773627@kao2.melbourne.sgi.com>
In-Reply-To: <24688.990773627@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Message-Id: <01052516035700.01561@idun>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A small overflow of the kernel stack overwrites the struct task at the
> bottom of the stack, recovery is dubious at best because we rely on
> data in struct task.  A large overflow of the kernel stack either
> corrupts the storage below this task's stack, which could hit anything,
> or it gets a stack fault.

Is there a reason for the task structure to be at the bottom rather than the 
top of these two pages ?

	Regards
		Oliver
