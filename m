Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbTJAI6M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 04:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbTJAI6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 04:58:12 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:63394 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262037AbTJAI6K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 04:58:10 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16250.38688.152166.875893@gargle.gargle.HOWL>
Date: Wed, 1 Oct 2003 10:58:08 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       perfctr-devel@lists.sourceforge.net
Subject: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
In-Reply-To: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org>
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus' 2.6.0-test6 announcement doesn't seem to mention the
fact that 2.6.0-test5-bk9 fundamentally changed the semantics
of /proc/self and the /proc/<pid> name space. These used to
map to actual (kernel) tasks, now they map to what I assume
are Posixly-correct processes (groups of tasks). In particular,
/proc/self is no longer an alias for `current'.

I don't actually disagree with the change, but it took me by
surprise since neither the 2.6.0-test6 annoucement nor the
diff between the t5-bk8 and t5-bk9 logs seem to mention it.

(It broke the perfctr driver, but I'm handling that by making
an already planned API switch now instead of later.)

/Mikael
