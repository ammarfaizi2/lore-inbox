Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263375AbUEWTIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbUEWTIm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 15:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbUEWTIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 15:08:42 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:12562 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S263375AbUEWTIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 15:08:40 -0400
Message-ID: <40B0F6B2.50605@cs.wisc.edu>
Date: Sun, 23 May 2004 14:08:34 -0500
From: Alexander Mirgorodskiy <mirg@cs.wisc.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: apm standby on thinkpad
References: <40AB65B3.2070102@cs.wisc.edu>
In-Reply-To: <40AB65B3.2070102@cs.wisc.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Mirgorodskiy wrote:
> [...]
> 
> (I did try 2.4.26, but it behaved even worse -- didn't wake up
> at all, even if standby was entered with "apm -S")

I have finally narrowed that second problem down to the 
CONFIG_X86_UP_APIC flag (Local APIC support on uniprocessors). That is, 
when the flag is set to "y", ThinkPad T41 cannot wake up after APM 
standby ("apm -S" or Fn-F3). It isn't specific to 2.4.26, happens on 
other 2.4 kernels I tried, as well as on 2.6.6.

Does anybody else see this problem on similar hardware?

Thanks,
Alex

