Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265592AbTFRXAv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 19:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265596AbTFRXAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 19:00:50 -0400
Received: from 66-122-194-202.ded.pacbell.net ([66.122.194.202]:16318 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S265592AbTFRXAt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 19:00:49 -0400
Subject: Re: [2.5.72] Oops on x86_64 running 32-bit code
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030618230626.GA27063@wotan.suse.de>
References: <1055976017.25153.74.camel@serpentine.internal.keyresearch.com>
	 <20030618224516.GF3543@wotan.suse.de>
	 <1055976671.25153.80.camel@serpentine.internal.keyresearch.com>
	 <20030618230626.GA27063@wotan.suse.de>
Content-Type: text/plain
Message-Id: <1055978087.25153.86.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 18 Jun 2003 16:14:47 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-18 at 16:06, Andi Kleen wrote:

> If it's a SuSE system you can use strace32, otherwise just copy
> over a 32bit strace binary from some i386 box.

Ugh - strace won't work, either.

I've slightly narrowed the problem down.  I'm using glibc 2.3.2 with TLS
and vsyscall support, but if I copy over an older 32-bit glibc,
everything is happy.

My guess is that 32-bit vsyscalls are still b0rked in some way under
2.5.72.

	<b

