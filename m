Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbTKTWxL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 17:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbTKTWxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 17:53:10 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:14292 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S263082AbTKTWxH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 17:53:07 -0500
Date: Fri, 21 Nov 2003 11:41:23 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Patrick's Test9 suspend code.
In-reply-to: <200311202233.09609.srhaque@iee.org>
To: Shaheed <srhaque@iee.org>
Cc: rob@landley.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1069368082.2239.66.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <200311201726.48097.srhaque@iee.org>
 <200311201339.45461.rob@landley.net> <200311202233.09609.srhaque@iee.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2003-11-21 at 11:33, Shaheed wrote:
> Understood. But by definition, there must be at least one page of data on the 
> filesystem whose location we know in order to do the resume. Why can't we 
> simply use one extra page to store this data?

Your reading of how the image is stored is correct, but it's not the
real issue, I'm afraid.

The question is more, why would you want this data. It doesn't make
sense to boot from one kernel, suspend, boot from another kernel,
suspend and then boot from the original kernel _unless_ in all of these
cases, all filesystems are mounted read-only. If they're not mounted
read-only, you'll get the cross linking and corruption Rob spoke of.

Whenever I switch from testing a 2.4 kernel to testing 2.6, I do a clean
boot for precisely this reason. I'd love it if I could just suspend 2.4,
boot the new 2.6 kernel, see if it suspends properly (to a different
swap, of course) and then resume the original 2.4 kernel. But doing so
would only work if I mounted 2.6 entirely read only, which is not what
you seem to be planning.

Regards,

Nigel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

