Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264637AbUFNXwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264637AbUFNXwG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 19:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264641AbUFNXwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 19:52:05 -0400
Received: from colin2.muc.de ([193.149.48.15]:48914 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264637AbUFNXv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 19:51:59 -0400
Date: 15 Jun 2004 01:51:57 +0200
Date: Tue, 15 Jun 2004 01:51:57 +0200
From: Andi Kleen <ak@muc.de>
To: "Nathaniel W. Filardo" <nwf@andrew.cmu.edu>
Cc: Andi Kleen <ak@muc.de>, stian@nixia.no, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] fix for Re: timer + fpu stuff locks my console race
Message-ID: <20040614235157.GD90963@colin2.muc.de>
References: <25iEn-7bv-3@gated-at.bofh.it> <m3n038o76h.fsf@averell.firstfloor.org> <Pine.LNX.4.58-035.0406141829330.3002@unix49.andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58-035.0406141829330.3002@unix49.andrew.cmu.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 06:33:32PM -0400, Nathaniel W. Filardo wrote:
> Using this patch (against 2.6.5-WOLK3.0), the system doen't crash (the
> program is given SIGSEGV), but it seems to also kill anything else using
> the FPU.  Including gkrellm2 with the GkrellWeather plugin.
> 
> Can anybody confirm this or is it just a strange "feature" of my system?

You probably have something using FP in the kernel or I overlooked a case
where it is legally used (then it would need an exception table entry too)
I would be interested in the decoded oops just for curiosity.

As for the fix you can just use Linus' simpler fix that went into -bk.

-Andi
