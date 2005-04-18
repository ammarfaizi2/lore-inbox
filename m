Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVDRFF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVDRFF4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 01:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVDRFF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 01:05:56 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:10675
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261670AbVDRFFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 01:05:52 -0400
Date: Sun, 17 Apr 2005 22:00:09 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Daniel Jacobowitz <dan@debian.org>
Cc: ikebe.takashi@lab.ntt.co.jp, cw@f00f.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
Message-Id: <20050417220009.2e1c6a13.davem@davemloft.net>
In-Reply-To: <20050418044223.GB15002@nevyn.them.org>
References: <4263275A.2020405@lab.ntt.co.jp>
	<20050418040718.GA31163@taniwha.stupidest.org>
	<4263356D.9080007@lab.ntt.co.jp>
	<20050418044223.GB15002@nevyn.them.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2005 00:42:23 -0400
Daniel Jacobowitz <dan@debian.org> wrote:

> On Mon, Apr 18, 2005 at 01:19:57PM +0900, Takashi Ikebe wrote:
> > GDB based approach seems not fit to our requirements. GDB(ptrace) based 
> > functions are basically need to be done when target process is stopping.
> > In addition to that current PTRACE_PEEK/POKE* allows us to copy only a 
> > *word* size...
> 
> While true, this is easily fixable.  There is even an interface
> precedent on OpenBSD (and possibly other platforms as well).

Some platforms even support the necessary PTRADE_{READ,WRITE}DATA
operations already, sparc is one such platform.
