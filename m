Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263724AbREYLyd>; Fri, 25 May 2001 07:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263725AbREYLyX>; Fri, 25 May 2001 07:54:23 -0400
Received: from ns.suse.de ([213.95.15.193]:22788 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S263724AbREYLyT>;
	Fri, 25 May 2001 07:54:19 -0400
Date: Fri, 25 May 2001 13:53:17 +0200
From: Andi Kleen <ak@suse.de>
To: Brian Gerst <bgerst@didntduck.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8
Message-ID: <20010525135317.B29643@gruyere.muc.suse.de>
In-Reply-To: <200105242110.OAA29766@csl.Stanford.EDU> <200105242308.f4ON8fv8015978@webber.adilger.int> <20010525013303.A21810@gruyere.muc.suse.de> <3B0E4762.7A7A3818@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B0E4762.7A7A3818@didntduck.org>; from bgerst@didntduck.org on Fri, May 25, 2001 at 07:52:02AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2001 at 07:52:02AM -0400, Brian Gerst wrote:
> Actually, you will never get a stack fault exception, since with a flat
> stack segment you can never get a limit violation.  All you will do is
> corrupt the data in task struct and cause an oops later on when the
> kernel tries to use the task struct.  There are only two ways to
> properly trap a kernel stack overflow:

In my experience the stack pointer eventually gets corrupted and starts 
pointing to some unmapped area, which gives you a stack fault (admittedly
a backtrace is a bit hard after that)

-Andi
