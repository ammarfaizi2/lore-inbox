Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272249AbSISS0M>; Thu, 19 Sep 2002 14:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272258AbSISS0M>; Thu, 19 Sep 2002 14:26:12 -0400
Received: from are.twiddle.net ([64.81.246.98]:7319 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S272249AbSISS0M>;
	Thu, 19 Sep 2002 14:26:12 -0400
Date: Thu, 19 Sep 2002 11:30:48 -0700
From: Richard Henderson <rth@twiddle.net>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       dvorak <dvorak@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: Syscall changes registers beyond %eax, on linux-i386
Message-ID: <20020919113048.A22520@twiddle.net>
Mail-Followup-To: Brian Gerst <bgerst@didntduck.org>,
	Petr Vandrovec <VANDROVE@vc.cvut.cz>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	dvorak <dvorak@xs4all.nl>, linux-kernel@vger.kernel.org
References: <24181C771D3@vcnet.vc.cvut.cz> <3D8A11BB.4090100@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D8A11BB.4090100@didntduck.org>; from bgerst@didntduck.org on Thu, Sep 19, 2002 at 02:04:43PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 02:04:43PM -0400, Brian Gerst wrote:
> Now that I've thought about it more, I think the best solution is to go 
> through all the syscalls (a big job, I know), and declare the parameters 
> as const, so that gcc knows it can't modify them, and will throw a 
> warning if we try.

The parameter area belongs to the callee, and it may *always* be modified.


r~
