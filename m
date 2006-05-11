Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751826AbWEKQWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbWEKQWb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 12:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbWEKQWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 12:22:31 -0400
Received: from aun.it.uu.se ([130.238.12.36]:30653 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1751826AbWEKQWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 12:22:30 -0400
Date: Thu, 11 May 2006 18:22:10 +0200 (MEST)
Message-Id: <200605111622.k4BGMAUn003662@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: kraxel@suse.de, rene.herman@keyaccess.nl
Subject: Re: [patch] SMP alternatives: skip with UP kernels.
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2006 14:13:22 +0200, Gerd Hoffmann wrote:
>+	if (0 == (__smp_alt_end - __smp_alt_begin))
>+		return; /* no tables, nothing to patch (UP kernel) */

That's an unnecessarily obscure way of stating the obvious:

	if (__smp_alt_end == __smp_alt_begin)
