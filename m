Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262156AbSJJTr2>; Thu, 10 Oct 2002 15:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262159AbSJJTr2>; Thu, 10 Oct 2002 15:47:28 -0400
Received: from holomorphy.com ([66.224.33.161]:49899 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262156AbSJJTr2>;
	Thu, 10 Oct 2002 15:47:28 -0400
Date: Thu, 10 Oct 2002 12:49:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Sampsa Ranta <sampsa@netsonic.fi>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops with?2.5.40
Message-ID: <20021010194950.GU10722@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Sampsa Ranta <sampsa@netsonic.fi>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0210102240450.22300-100000@nalle.netsonic.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0210102240450.22300-100000@nalle.netsonic.fi>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 10:46:02PM +0300, Sampsa Ranta wrote:
> Call Trace:
>  [<c013897f>]change_protection+0x1af/0x200
>  [<c0138af3>]mprotect_attempt_merge+0x123/0x1e0
>  [<c0138d3d>]mprotect_fixup+0x18d/0x1b0
>  [<c0138ec4>]sys_mprotect+0x164/0x2f3
>  [<c014d541>]sys_write+0x31/0x40
>  [<c010786f>]syscall_call+0x7/0xb
> Code: 23 53 7c 39 58 60 75 38 8b 40 5c 85 c0 74 08 0f 20 d8 0f 22
>  <6>note: java[11999] exited with preempt_count 2

Fixed by Hugh in:

ChangeSet@1.750, 2002-10-10 11:03:56-07:00, akpm@digeo.com
  [PATCH] mremap use-after-free bugfix



Bill
