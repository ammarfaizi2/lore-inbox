Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbUKOVUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUKOVUK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 16:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbUKOVUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 16:20:08 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:37008 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261278AbUKOVTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 16:19:01 -0500
Date: Mon, 15 Nov 2004 21:18:43 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] WTF is VLI?
In-Reply-To: <200411122326.iACNQSEn006943@gue01.inform.pucp.edu.pe>
Message-ID: <Pine.LNX.4.44.0411152110460.4171-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2004, Horst von Brand wrote:
> Dave Jones <davej@redhat.com> said:
> > On Thu, Nov 11, 2004 at 09:05:11PM +0000, Hugh Dickins wrote:
> >  > What is this "VLI" that 2.6.9 started putting after the taint string
> >  > in i386 oopses?  Vick Library Index?  Vineyard Leadership Institute?
> > 
> > "Variable length instructions".  I think newer ksymoops looks
> > for this tag and does something magical when doing disassembly.
> 
> Huh? Either an architecture has them (i386) or doesn't (RISCs). 
> Or am I seriously misunderstanding here?

I share your surprise, it does seem rather odd.  I think what it's
really trying to do is distinguish how 2.6.9 starts the "Code:" bytes
at eip - 43, where 2.6.8 started at eip; but flag that since it's VLI
then it's got a bit of guessing to do.  I'd have preferred to work it
out from i386 and the new "<%02x>" around the eip byte itself, rather
than stick a "VLI" somewhere else; but let's not interfere now it's so.

Hugh

