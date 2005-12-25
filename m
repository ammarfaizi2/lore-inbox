Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVLYJkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVLYJkJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 04:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbVLYJkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 04:40:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27534 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750806AbVLYJkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 04:40:08 -0500
Subject: Re: FS possible security exposure ?
From: Arjan van de Ven <arjan@infradead.org>
To: regatta <regatta@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5a3ed5650512250129t434d2b42kc1ebac1c5b308986@mail.gmail.com>
References: <5a3ed5650512250129t434d2b42kc1ebac1c5b308986@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 25 Dec 2005 10:40:00 +0100
Message-Id: <1135503601.2946.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> (when you have hundred of users and hundred of NFS and thousand of 
> net groups you don't want a user to edit other file just because he
> has write permission in the patent dir).

if you have write permission in the directory you're allowed to
1) create new files
2) rename existing files
3) delete files
4) rename files over existing files (combo of 2 and 3 sort of)

so an "edit" as you describe is
* create a new file with the new (eg modified) content
* rename the new file over the existing file

that's how reliable editors operate (the rename-over-file is an atomic
operation) to avoid any possibility of dataloss due to crashes etc.

Since the 1-4 rules are pretty much there for all unixes...
Maybe your solaris editor doesn't do editing in this way?



