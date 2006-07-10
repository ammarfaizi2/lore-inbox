Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161127AbWGJNJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161127AbWGJNJh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 09:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161134AbWGJNJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 09:09:37 -0400
Received: from khc.piap.pl ([195.187.100.11]:21437 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1161115AbWGJNJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 09:09:36 -0400
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
Date: Mon, 10 Jul 2006 15:09:32 +0200
In-Reply-To: <44B248E4.2020506@pol.net> (Antonino A. Daplas's message of "Mon, 10 Jul 2006 20:32:36 +0800")
Message-ID: <m3y7v14neb.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Antonino A. Daplas" <adaplas@pol.net> writes:

>> You're right here, I don't know why I assumed DEPENDS does it
>> automatically.
>
> Use select.

It has a known problem - if the "selected" thing changes (requires
another option etc) things are screwed. With "depends on", you don't
have to track such changes.

While near selects (in the same build directory) are IMHO ok, far
ones are not.

I think it would be different if trying to select something which
can't be selected automatically resulted in a warning. I think
I have to look at it then, but for now I'll use something like
"depends on (FB_CIRRUS=m && I2C && I2C_ALGOBIT) ||
(FB_CIRRUS=y && I2C=y && I2C_ALGOBIT=y)".
-- 
Krzysztof Halasa
