Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUF3V70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUF3V70 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 17:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbUF3V7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 17:59:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:57748 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263003AbUF3V7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 17:59:24 -0400
Date: Wed, 30 Jun 2004 14:55:06 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Joshua <jhudson@cyberspace.org>
Cc: miller@techsource.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore floppy boot image
Message-Id: <20040630145506.46d3af16.rddunlap@osdl.org>
In-Reply-To: <Pine.SUN.3.96.1040630174704.20503A-100000@grex.cyberspace.org>
References: <40E3319D.3050100@techsource.com>
	<Pine.SUN.3.96.1040630174704.20503A-100000@grex.cyberspace.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jun 2004 17:52:30 -0400 (EDT) Joshua wrote:

| Thanks for the time in reading the patch.
| 
| Hmm. pop %ax after the jmp is a clear bug. Must have been a zero
| on the stack when I tested it. <g>
| 
| For the clobbering of al just before kernel entry, that is badly arranged
| code although it doesn't matter (mov $0, %al turns out to be no-op).

No-op should be some form/variant of xchg %ax,%ax 
(not mov to %al -- the latter needs to do something.)

| I'll fix the bugs if anybody still wants the patch.
| I'll fix it anyway for myself <g>.

--
~Randy
