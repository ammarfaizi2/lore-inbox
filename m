Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbUCIXUQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 18:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbUCIXUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 18:20:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:3537 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262325AbUCIXUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 18:20:10 -0500
Date: Tue, 9 Mar 2004 15:18:29 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Rick Knight <rick@rlknight.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dummy network device
Message-Id: <20040309151829.5965c186.rddunlap@osdl.org>
In-Reply-To: <404E4F34.7000301@rlknight.com>
References: <404E4F34.7000301@rlknight.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Mar 2004 15:11:48 -0800 Rick Knight wrote:

| > Hello,
| >
| > After I upgraded to 2.6.3 from 2.4.20 I discovered that I can only get 
| > 1 dummy device. I need to be able to load 3 dummy network devices. 
| > Scouring the kernel archives, it looks like this can be accomplished 
| > through MODULE_PARAMS, but I can find no information on the 
| > module_params are or how to use them. I have dummy built as a module 
| > and it does load at startup as dummy0. How do I get dummy1 and dummy2?
| >
| > In answering this message, please CC me.
| >
| > Thanks for your help,
| > Rick Knight
| > (rick@rlknight.com)
| 
| 
| Never mind,
| 
| I found the answer. From the archive. Decided to look at dummy.c and 
| numdummies=1, changed it to numdummies=3 and rebuilt that module. Works 
| like a charm.
| 
| Question/Suggestion, couldn't this be made an option at configuration? 
| Kind of like number_of_ptys=256.

It's supposed to be changeable at module load time, without
rebuilding it.  Try this e.g.:

modprobe dummy numdummies=4

--
~Randy
