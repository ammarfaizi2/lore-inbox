Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVGLKyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVGLKyY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 06:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVGLKyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 06:54:24 -0400
Received: from nproxy.gmail.com ([64.233.182.206]:5018 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261290AbVGLKyW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 06:54:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Lg5LZfOMukxwBSFRxWdsvhI9Qh4MIMZ763+e2dw9/FWxKp+gsgjwUEA7UPaG6r8I19LNa2B3cTpmflVJvoe5ksYEqoLebYwG654K6NPuMMV6V4HoGjQDirCXPvWL3PhvQBqGvqYbFJWtsZVQbQgDiCJXPc0h9BUJiSe70a38BHQ=
Message-ID: <6278d2220507120354724648b3@mail.gmail.com>
Date: Tue, 12 Jul 2005 11:54:21 +0100
From: Daniel J Blueman <daniel.blueman@gmail.com>
Reply-To: Daniel J Blueman <daniel.blueman@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems with more than 8 AMD Opteron Cores per System
In-Reply-To: <6278d22205071203185a50a104@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6278d22205071203185a50a104@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure your BIOS supports the stepping of the Opterons you have. Eg, if
you have the Iwill H8501, BIOS v1.8 [1] covers all the current
steppings. You may even encounter problems if you mix different
steppings.

--- [1]

http://www.iwill.net/product_2s.asp?p_id=90&tp=BIOS

Oliver Weihe wrote:
> Hello,
>
> I've two Iwill 8way Opteron equipped with 8 Opteron 875 CPUs each.
> (In the past we build some systems with singlecore CPUs and they went
> very well)
>
> The Problem now is that the machines crash during boot when maxcpus is
> greater than 8.
> 2.6.12-rc4 works well with maxcpus=8, with 9 or more it freezes after
> "Testing NMI Watchdog... OK"
>
> 2.6.12-rc5 and above have more problems even with maxcpus=4 or less very
> early during booting.
>
> 2.6.13-X crashes later during boot (from 2 to 16 cores it's the same
> behavior)
>
> The last I can so on the console (kernel 2.6.13-rc2-git4, maxcpus=2..16)
> is:
>
> NET: Registered protocol family 1
> Using IPI Shortcut mode
> int3: 0000 [1] SMP
> CPU4
> Modules linked in:
> Freeing unused kernel memory: 212k freed
> Pid: 0, comm: swapper Not tainted 2.6.13-rc2-git4-default
> RIP: 0010:[<ffffffff8050fc00>]
>
> After that the machines are totally freezed.
>
> With maxcpus=1 all (tested) versions >=2.6.12-rc3 are able to boot.
>
> Any hints/ideas/what ever?
>
> Regards,
>    Oliver Weihe
>
> P.S. if you answer CC me ;)
___
Daniel J Blueman
