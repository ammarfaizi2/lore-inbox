Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWHAWwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWHAWwI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 18:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWHAWwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 18:52:08 -0400
Received: from v6.netlin.pl ([62.121.136.6]:35750 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S1750703AbWHAWwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 18:52:07 -0400
Message-ID: <32831.83.29.18.163.1154472723.squirrel@83.29.18.163>
Date: Wed, 2 Aug 2006 00:52:03 +0200 (CEST)
Subject: strange issues with simple net module for 2.4
From: gj@pointblue.com.pl
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/* Please do CC me on replies, I am not subscribed to the list. */

hi devs

I have spend some time, and wrote very simple NET device module for 2.4
kernels. It does allocate certain number of paired net interfaces named
tola%d , where for instance:
tola(N*2)<->tola(N*2)+1

anything you send to tola0, appears on tola1, and the other way around,
same for all Ns.

http://podgorze.pl/~gj/tola.tar.bz2
(~2kb)

there are few issues however.
First of all, I am not able to allocate more than 50 pairs (the param is
at the top of the source - int nrofi; ). Secondly, every once in a while
it crashes badly on unload, and frankly - I have no idea why.

Once again, this is 2.4.X module! The reason being, we are using here only
2.4 series for networking for various reasons that I don't want to get
into now.
I do appriciate any help or hints regarding this module please.



