Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271740AbTG2N7v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 09:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271748AbTG2N7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 09:59:51 -0400
Received: from modemcable198.171-130-66.que.mc.videotron.ca ([66.130.171.198]:62852
	"EHLO gaston") by vger.kernel.org with ESMTP id S271740AbTG2N7P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 09:59:15 -0400
Subject: Re: [PATCH] Framebuffer: client notification mecanism & PM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <89CD6530893@vcnet.vc.cvut.cz>
References: <89CD6530893@vcnet.vc.cvut.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059487140.8537.35.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 29 Jul 2003 09:59:00 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-29 at 09:39, Petr Vandrovec wrote:

> Oops... You probably did not want IBM LCD diffs in fbmem.c posted.
> 
> matroxfb tried to use a 'dead' for handling hot removal, but your code
> looks definitely saner

Hrm... right, that ibmlcd bit can go ;) Hopefully someone else will
get the real ibmlcd driver in sooner or later...

My code wasn't really intended to deal with hot-removal, more with
"what happens if printk occurs during the Power Management suspend
sequence", but I tried to keep the notification mecanism simple
enough so it could be used for that as well. Also, indeed, the fbcon
changes should deal with hot-removal in some way (though you surely
also want to "deatch" from the fbdev's in this case).

Among other things that could be used for is live monitor insertion/
removal detection (some HW are able to do that), "pivot" monitor
kind of things, etc... typically via the mode_changed hook.

Ben.

