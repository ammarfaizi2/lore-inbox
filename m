Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbULGPlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbULGPlB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 10:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbULGPlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 10:41:01 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:26797 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261843AbULGPk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 10:40:56 -0500
Subject: Bug in kmem_cache_create with duplicate names
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Tue, 07 Dec 2004 10:40:56 -0500
Message-Id: <1102434056.25841.260.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it really necessary to BUG on creating a cache with a duplicate name?
Wouldn't it just be better to fail the create. The reason I mentioned
this is that I was writing some modules and after doing a cut and paste,
I forgot to change a name of a cache that was created by one module and
I used it in another existing module.  So you can say that it was indeed
a bug, but did it really need to crash my machine?  I aways check the
return codes in my modules, and I would have figured it out why it
failed, but I didn't expect a simple module to crash the machine the way
it did.  Well anyway it did definitely show me where my bug was.

Thanks,

-- Steve

