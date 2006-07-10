Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWGJNaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWGJNaj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 09:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbWGJNaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 09:30:39 -0400
Received: from khc.piap.pl ([195.187.100.11]:45518 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S964786AbWGJNai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 09:30:38 -0400
To: "Antonino A. Daplas" <adaplas@pol.net>
Cc: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cirrus-logic-framebuffer-i2c-support.patch
References: <200607050147.k651kxmT023763@shell0.pdx.osdl.net>
	<20060705165255.ab7f1b83.khali@linux-fr.org>
	<m3bqryv7jx.fsf_-_@defiant.localdomain> <44B196ED.1070804@pol.net>
	<m3irm5hjr0.fsf@defiant.localdomain> <44B226E8.40104@pol.net>
	<m3mzbh68g9.fsf@defiant.localdomain> <44B2398B.7040300@pol.net>
	<m3ejwt65of.fsf@defiant.localdomain> <44B248E4.2020506@pol.net>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 10 Jul 2006 15:27:10 +0200
In-Reply-To: <44B248E4.2020506@pol.net> (Antonino A. Daplas's message of "Mon, 10 Jul 2006 20:32:36 +0800")
Message-ID: <m3u05p4mkx.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Antonino A. Daplas" <adaplas@pol.net> writes:

> Eventually, I'm the one who's going to maintain the code, most
> of the drivers in the video directory are practically abandoned. 

BTW, it's fortunate that you are maintaing it. The I2C code in cirrusfb
uses vga_wseq() and vga_rseq(). Is it safe WRT races between I2C
adapter code and fb code? I don't see any locking here, and both
functions are non-atomic (write merging and posting will not break it,
but it looks like I need a lock for concurent access).
-- 
Krzysztof Halasa
