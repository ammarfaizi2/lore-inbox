Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVDIW6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVDIW6H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 18:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVDIW6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 18:58:07 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:44989
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261398AbVDIW6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 18:58:04 -0400
Date: Sat, 9 Apr 2005 15:55:11 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: andrea@suse.de, mbp@sourcefrog.net, linux-kernel@vger.kernel.org,
       dlang@digitalinsight.com
Subject: Re: Kernel SCM saga..
Message-Id: <20050409155511.7432d5c7.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0504082240460.28951@ppc970.osdl.org>
References: <pan.2005.04.07.01.40.20.998237@sourcefrog.net>
	<20050407014727.GA17970@havoc.gtf.org>
	<pan.2005.04.07.02.25.56.501269@sourcefrog.net>
	<Pine.LNX.4.62.0504061931560.10158@qynat.qvtvafvgr.pbz>
	<1112852302.29544.75.camel@hope>
	<Pine.LNX.4.58.0504071626290.28951@ppc970.osdl.org>
	<1112939769.29544.161.camel@hope>
	<Pine.LNX.4.58.0504072334310.28951@ppc970.osdl.org>
	<20050408083839.GC3957@opteron.random>
	<Pine.LNX.4.58.0504081647510.28951@ppc970.osdl.org>
	<20050409022701.GA14085@opteron.random>
	<Pine.LNX.4.58.0504082240460.28951@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2005 22:45:18 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> Also, I don't want people editing repostitory files by hand. Sure, the 
> sha1 catches it, but still... I'd rather force the low-level ops to use 
> the proper helper routines. Which is why it's a raw zlib compressed blob, 
> not a gzipped file.

I understand the arguments for compression, but I hate it for one
simple reason: recovery is more difficult when you corrupt some
file in your repository.

It's happened to me more than once and I did lose data.

Without compression, I might be able to recover if something
causes a block of zeros to be written to the middle of some
repository file.  With compression, you pretty much just lose.
