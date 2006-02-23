Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWBWRqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWBWRqd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWBWRqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:46:32 -0500
Received: from kanga.kvack.org ([66.96.29.28]:63106 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932365AbWBWRqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:46:32 -0500
Date: Thu, 23 Feb 2006 12:39:07 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: hpa@zytor.com, klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: sys_mmap2 on different architectures
Message-ID: <20060223173907.GF27682@kvack.org>
References: <43FCDB8A.5060100@zytor.com> <20060223001411.GA20487@kvack.org> <20060222.164347.12864037.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222.164347.12864037.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 04:43:47PM -0800, David S. Miller wrote:
> Aha, that part I didn't catch.  Thanks for the clarification
> Ben.
> 
> I wonder why we did things that way with a fixed shift...

Without that trick, we'd have needed an extra parameter for the syscall 
on x86, which is already at the maximum number of registers with 6 
arguments.  This was easier than changing the syscall ABI. =-)

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
