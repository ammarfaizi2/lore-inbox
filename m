Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263478AbTDSWGi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 18:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbTDSWGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 18:06:38 -0400
Received: from hera.cwi.nl ([192.16.191.8]:47099 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263478AbTDSWGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 18:06:37 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 20 Apr 2003 00:18:36 +0200 (MEST)
Message-Id: <UTC200304192218.h3JMIak17446.aeb@smtp.cwi.nl>
To: aebr@win.tue.nl, akpm@digeo.com
Subject: Re: Private namespaces
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How does this look?

Ach - just a moment ago I submitted only that single
improvement, but you do the whole list.

(It is OK, of course. I looked for a second and concluded that
in all other cases the return value was in fact -ENOMEM, so that
no change was required. Only in the case of security_task_alloc()
is a different value, -EPERM, likely.)

Concerning style - I don't like

	if ((retval = copy_sighand(clone_flags, p)))

very much.

Where there is an if() one expects a boolean condition,
and in superficial reading one can easily mistake = for ==,
in spite of the additional parentheses.

Just

	retval = copy_sighand(clone_flags, p);
	if (retval)

is so much clearer.

Andries
