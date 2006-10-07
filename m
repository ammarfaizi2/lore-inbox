Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751564AbWJGD73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbWJGD73 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 23:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWJGD72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 23:59:28 -0400
Received: from sycorax.lbl.gov ([128.3.5.196]:18439 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S1751562AbWJGD72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 23:59:28 -0400
From: Alex Romosan <romosan@sycorax.lbl.gov>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, linville@tuxdriver.com,
       netdev@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org
Subject: Re: 2.6.19-rc1 regression: airo suspend fails
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
	<871wpmoyjv.fsf@sycorax.lbl.gov> <20061006184706.GR16812@stusta.de>
Date: Fri, 06 Oct 2006 20:54:59 -0700
In-Reply-To: <20061006184706.GR16812@stusta.de> (message from Adrian Bunk on
	Fri, 6 Oct 2006 20:47:07 +0200)
Message-ID: <87y7rszsoc.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> On Thu, Oct 05, 2006 at 09:31:16PM -0700, Alex Romosan wrote:
>> Linus Torvalds <torvalds@osdl.org> writes:
>> 
>> > so please give it a good testing, and let's see if there are any 
>> > regressions.
>> 
>> it breaks suspend when the airo module is loaded:
>> 
>> kernel: Stopping tasks: =================================================================================
>> kernel:  stopping tasks timed out after 20 seconds (1 tasks remaining):
>> kernel:   eth1
>> kernel: Restarting tasks...<6> Strange, eth1 not stopped
>> 
>> if i remove the airo module suspend works normally (this is on a
>> thinkpad t40).
>
> Thanks for your report.
>
> Let's try to figure out what broke it.
>
> As a first step, please replace drivers/net/wireless/airo.c with the 
> version in 2.6.18 and check whether this fixes the issue (you can ignore 
> the deprecated warning during compilation).

i replaced airo.c with the 2.6.18 version. the good news is i can
suspend to memory with it. the bad news is dhcp never got an ip
address (so i don't think the 2.6.18 driver really works with the
2.6.19-rc1 infrastructure). any patches i could try? thanks.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
