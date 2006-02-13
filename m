Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWBMTxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWBMTxv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWBMTxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:53:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22684 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964834AbWBMTxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:53:50 -0500
Date: Mon, 13 Feb 2006 11:52:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: mingo@elte.hu, tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] hrtimer: remove useless const
Message-Id: <20060213115248.2f6445f4.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0602131339330.30994@scrub.home>
References: <Pine.LNX.4.61.0602130209340.23804@scrub.home>
	<1139830116.2480.464.camel@localhost.localdomain>
	<Pine.LNX.4.61.0602131235180.30994@scrub.home>
	<20060213114612.GA30500@elte.hu>
	<20060213035354.65b04c15.akpm@osdl.org>
	<Pine.LNX.4.61.0602131315150.30994@scrub.home>
	<20060213043038.25a49dd0.akpm@osdl.org>
	<Pine.LNX.4.61.0602131339330.30994@scrub.home>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> wrote:
>
> On Mon, 13 Feb 2006, Andrew Morton wrote:
> 
>  > const arguments to functions are pretty useful for code readability and
>  > maintainability too, if you use them consistently.
> 
>  I could understand that argument, if gcc would warn about it in any way.

It does.  If a function tries to modify a formal argument which was marked
const you'll get a warning.

We're talking about different things here.  My point is that it is
perverted and evil for a function to modify its own args (unless it's very
small and simple), and a const declaration is a useful way for a
maintenance programmer to be assured that nobody has done perverted and
evil things to a function.
