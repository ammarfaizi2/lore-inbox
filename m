Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422810AbWGJUeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422810AbWGJUeU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 16:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422811AbWGJUeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 16:34:20 -0400
Received: from khc.piap.pl ([195.187.100.11]:26241 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1422810AbWGJUeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 16:34:19 -0400
To: "Antonino A. Daplas" <adaplas@pol.net>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>,
       Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cirrus-logic-framebuffer-i2c-support.patch
References: <200607050147.k651kxmT023763@shell0.pdx.osdl.net>
	<20060705165255.ab7f1b83.khali@linux-fr.org>
	<m3bqryv7jx.fsf_-_@defiant.localdomain> <44B196ED.1070804@pol.net>
	<m3irm5hjr0.fsf@defiant.localdomain> <44B226E8.40104@pol.net>
	<m3mzbh68g9.fsf@defiant.localdomain> <44B2398B.7040300@pol.net>
	<m3ejwt65of.fsf@defiant.localdomain> <44B248E4.2020506@pol.net>
	<m3u05p4mkx.fsf@defiant.localdomain> <44B26004.4050500@gmail.com>
	<m3r70tqxmt.fsf@defiant.localdomain> <44B2808F.8000901@pol.net>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 10 Jul 2006 22:34:17 +0200
In-Reply-To: <44B2808F.8000901@pol.net> (Antonino A. Daplas's message of "Tue, 11 Jul 2006 00:30:07 +0800")
Message-ID: <m3ac7h6vxy.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Antonino A. Daplas" <adaplas@pol.net> writes:

> This is no-man's land.  Basically X grabs the VT with KD_GRAPHICS mode
> set.  When in KD_GRAPHICS mode, the framebuffer console will not
> send any commands to the drivers. The problem is trying to do
> framebuffer operation while in X, we don't have any guards on that.
> Just try fbset mymode while in X.

You mean it will not bomb? Good, but still there is I2C question
- can I2C accesses to the graphics chip corrupt X11 and vice versa?
I can't see anything preventing that, and while we can disable
graphic operations while Xserver is running, we can't disable I2C
(non-DDC).

Probably X11 should be disallowed to use I2C directly? I should
probably Cc: this to XOrg as well...
-- 
Krzysztof Halasa
