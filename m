Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266938AbUAXM0y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 07:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266940AbUAXM0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 07:26:54 -0500
Received: from post1.dk ([62.242.36.44]:13066 "EHLO post1.dk")
	by vger.kernel.org with ESMTP id S266938AbUAXM0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 07:26:52 -0500
Content-Disposition: inline
Content-Transfer-Encoding: binary
MIME-Version: 1.0
To: Richard Chan <rspchan@starhub.net.sg>
Subject: Re: [KBUILD] md/raid6 breaks separate source/object tree
From: sam@ravnborg.org
Reply-To: sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=iso-8859-1
X-Mailer: acmemail <URL:http://www.astray.com/acmemail/>
Message-Id: <20040124122651.46D2915C24@post1.dk>
Date: Sat, 24 Jan 2004 13:26:51 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Lør, 24 Jan 2004 20:10:25 +0800 skrev Richard Chan <rspchan@starhub.net.sg> : 


>md/raid6 is using an in-tree perl script to generate a C file.
>This breaks kbuild separate src/obj tree.

>Somehow the src in $(PERL) $(src)/drivers/md/unroll.pl is not
>getting substituted.

Replace $(src)/unroll.pl with $(srctree)/$(src)/unroll.pl in
drivers/md/Makefile and it works again.

Fix is already sent to hpa/akpm - but I do not have it available
here (on WEB mail).

   Sam
