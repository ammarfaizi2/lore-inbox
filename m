Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269041AbUHMJQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269041AbUHMJQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 05:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269042AbUHMJQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 05:16:57 -0400
Received: from holomorphy.com ([207.189.100.168]:60305 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269039AbUHMJQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 05:16:54 -0400
Date: Fri, 13 Aug 2004 02:16:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>, Keith Owens <kaos@ocs.com.au>,
       Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH][2.6] Completely out of line spinlocks / i386
Message-ID: <20040813091640.GZ11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@osdl.org>,
	Pavel Machek <pavel@ucw.cz>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
References: <Pine.LNX.4.58.0408111511380.1839@ppc970.osdl.org> <23701.1092268910@ocs3.ocs.com.au> <20040812010115.GY11200@holomorphy.com> <Pine.LNX.4.58.0408112133470.2544@montezuma.fsmlabs.com> <20040812020424.GB11200@holomorphy.com> <20040812072058.GH11200@holomorphy.com> <20040813080116.GY11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813080116.GY11200@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 01:01:16AM -0700, William Lee Irwin III wrote:
> Most of this is consolidating preempt_count()++ and preempt_count()--
> when CONFIG_PREEMPT=y. Removing CONFIG_PREEMPT from the .config yields:
>               text    data     bss     dec     hex filename
> mainline: 19973522        6607761 1878448 28459731        1b242d3 vmlinux
> cool:     19839487        6585707 1878448 28303642        1afe11a vmlinux
> C-func:   19923848        6582771 1878384 28385003        1b11eeb vmlinux

Reinlining spin_unlock() yields:
unlock:     19895498        6582746 1878384 28356628        1b0b014 vmlinux


-- wli
