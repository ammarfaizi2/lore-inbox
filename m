Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267943AbUJOOnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267943AbUJOOnc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 10:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267953AbUJOOnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 10:43:32 -0400
Received: from vsmtp4alice-fr.tin.it ([212.216.176.150]:7415 "EHLO
	vsmtp4.tin.it") by vger.kernel.org with ESMTP id S267943AbUJOOnT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 10:43:19 -0400
Subject: janitoring printk with no KERN_ constants, kill all defaults?
From: Daniele Pizzoni <auouo@tin.it>
To: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>
Cc: pazke@orbita.don.sitek.net
Content-Type: text/plain
Message-Id: <1097855099.3004.64.camel@pdp11.tsho.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 15 Oct 2004 17:44:59 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm investigating this (from the kernel janitors TODO list):

------------------------------------------------------------------------
From: Andrey Panin <pazke at orbita dot don dot sitek dot net>

- check printk() calls (should include appropriate KERN_* constant).

------------------------------------------------------------------------

printk ends up using the default KERN_WARNING constant when no costant
is explicitly specified; the default is changeable. So a printk with
_no_ constant specified means "use the current default" and could be,
maybe in some cases only, a developer choice.

I ask, what rationale there is behind checking all printks to include
the "appropriate" constant? Should then we make printk fail when called
without KERN_ constant? Or can I force with a sed script all defaulted
printk to KERN_WARNING?

I'm looking for advice, or a pointer to an appropriate thread of the
lkml archives.

Thanks
Daniele Pizzoni <auouo@tin.it>


