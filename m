Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272617AbTG0XWx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 19:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272570AbTG0Wz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 18:55:58 -0400
Received: from zeus.kernel.org ([204.152.189.113]:28659 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272381AbTG0WzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:55:14 -0400
Date: Sun, 27 Jul 2003 23:35:01 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Cc: mingo@elte.hu, kernel@kolivas.net, riel@surriel.com, wind@cocodriloo.com
Subject: fairsched for o(1)-scheduler
Message-ID: <20030727213501.GA23621@wind.cocodriloo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Given I've got spare time now, I'm trying to revive and finally
have a working implementation for the 2.6 fairsched patch.

Since my early attempts crashed, I would appreciate peer review
and advise on how to do a first implementation.

I was told that printk should not be used inside the scheduler,
is this true?

Also, in order to park tasks aside, I created another prio_array
besides the active and expired ones, queuing expired tasks there
until the used could afford to move them to the active one. Does
the scheduler assume, in implicit form, that a task is either on
the active or expired array?

The proposed design is described at this page:

http://wind.cocodriloo.com/~wind/fairsched/

And also by Hubertus Franke on his OLS 2003 paper:

http://archive.linuxsymposium.org/ols2003/Proceedings/All-Reprints/Reprint-Franke-OLS2003.pdf


Greets, Antonio.

-- 

1. Dado un programa, siempre tiene al menos un fallo.
2. Dadas varias lineas de codigo, siempre se pueden acortar a menos lineas.
3. Por induccion, todos los programas se pueden
   reducir a una linea que no funciona.
