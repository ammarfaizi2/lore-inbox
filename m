Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265761AbUEZSNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265761AbUEZSNL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 14:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265762AbUEZSNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 14:13:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32729 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265761AbUEZSNK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 14:13:10 -0400
Date: Wed, 26 May 2004 11:12:22 -0700
From: "David S. Miller" <davem@redhat.com>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: mingo@elte.hu, andrea@suse.de, riel@redhat.com, torvalds@osdl.org,
       arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 4k stacks in 2.6
Message-Id: <20040526111222.4159a771.davem@redhat.com>
In-Reply-To: <20040526125014.GE12142@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.44.0405251549530.26157-100000@chimarrao.boston.redhat.com>
	<Pine.LNX.4.44.0405251607520.26157-100000@chimarrao.boston.redhat.com>
	<20040525211522.GF29378@dualathlon.random>
	<20040526103303.GA7008@elte.hu>
	<20040526125014.GE12142@wohnheim.fh-wedel.de>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2004 14:50:14 +0200
Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:

> Change gcc to catch stack overflows before the fact and disallow
> module load unless modules have those checks as well.

That's easy, just enable profiling then implement a suitable
_mcount that checks for stack overflow.  I bet someone has done
this already.

For full coverage, some trap entry handler checks in entry.S
would be necessary too of course.
