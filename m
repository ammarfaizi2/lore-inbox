Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272633AbSISTgc>; Thu, 19 Sep 2002 15:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272522AbSISTgc>; Thu, 19 Sep 2002 15:36:32 -0400
Received: from are.twiddle.net ([64.81.246.98]:13207 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S272633AbSISTgb>;
	Thu, 19 Sep 2002 15:36:31 -0400
Date: Thu, 19 Sep 2002 12:41:17 -0700
From: Richard Henderson <rth@twiddle.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Brian Gerst <bgerst@didntduck.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       dvorak <dvorak@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: Syscall changes registers beyond %eax, on linux-i386
Message-ID: <20020919124117.A22720@twiddle.net>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Brian Gerst <bgerst@didntduck.org>,
	Petr Vandrovec <VANDROVE@vc.cvut.cz>, dvorak <dvorak@xs4all.nl>,
	linux-kernel@vger.kernel.org
References: <20020919115747.A22594@twiddle.net> <Pine.LNX.3.95.1020919152301.15882B-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.95.1020919152301.15882B-100000@chaos.analogic.com>; from root@chaos.analogic.com on Thu, Sep 19, 2002 at 03:40:52PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 03:40:52PM -0400, Richard B. Johnson wrote:
> Well it's not modifying those values.

It's not modifying "a", true, but it _is_ modifying the parameter
area.  Which is exactly the kernel bug in question.

> It's really bad code because it could have done:
> 
> 	incl	$0x04(%esp)
> 	incl	$0x08(%esp)
> 	incl	$0x1c(%esp)
> 	jmp	bar

Yes, I know.


r~
