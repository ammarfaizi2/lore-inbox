Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264948AbTGKTV2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 15:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265549AbTGKTTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 15:19:38 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:37773 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S265542AbTGKTS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 15:18:26 -0400
Message-Id: <200307111932.h6BJWMr5004606@eeyore.valparaiso.cl>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Style question: Should one check for NULL pointers? 
In-Reply-To: Your message of "Thu, 10 Jul 2003 16:28:09 -0400."
             <Pine.LNX.4.44L0.0307101606060.22398-100000@netrider.rowland.org> 
X-Mailer: MH-E 7.1; nmh 1.0.4; XEmacs 21.4
Date: Fri, 11 Jul 2003 15:32:20 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> said:

[...]

> Suppose everything is working correctly and the pointer never is NULL.  
> Then it really doesn't matter whether you check or not;  the loss in code
> speed and size is completely negligible (except maybe deep in some inner
> loop).  But there is a loss in code clarity; when I see a check like that
> it makes me think, "What's that doing there?  Can that pointer ever be
> NULL, or is someone just being paranoid?"  Distractions of that sort don't
> help when trying to read code.

My personal paranoia when reading code goes the other way: How can I be
sure it won´t ever be NULL?  Maybe it can't be now (and to find that out an
hour grepping around goes by), but the very next patch introduces the
possibility.  Better have the function do an extra check, or make sure
somehow the assumption won't _ever_ be violated. But that is a large (huge,
even) cost, so...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
