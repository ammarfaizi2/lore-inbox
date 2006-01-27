Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422688AbWA0Xcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422688AbWA0Xcj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 18:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422689AbWA0Xcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 18:32:39 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:43013 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1422688AbWA0Xci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 18:32:38 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <hyc@symas.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
Date: Fri, 27 Jan 2006 15:31:59 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKGEIJJLAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <43DA8F4F.50000@symas.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Fri, 27 Jan 2006 15:28:47 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Fri, 27 Jan 2006 15:28:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> David, you specifically have been faced with this question before:
> http://groups.google.com/group/comp.programming.threads/browse_frm
> /thread/2184ba84f911d9dd/a6e4f7cf13bbec2d#a6e4f7cf13bbec2d
> and you didn't dispute the interpretation then. The wording for
> pthread_mutex_unlock hasn't changed between 2001 and now.

	This was a totally different question. This was about the implementation,
not the interpretation. You'll note that I objected to the implementation.

> And here:
>
http://groups.google.com/group/comp.programming.threads/msg/89cc5d600e34e88a
?hl=en&

	Again, I don't see that I commented on the interpretation. This was an
unfortunate missed oppurtunity. Kaz is incorrect here.

> If those statements were incorrect, I have a feeling someone would have
> corrected them at the time. Certainly you can attest to that.

	Obviously not, since they are incorrect and nobody did.

>
http://groups.google.com/group/comp.programming.threads/msg/d5b2231ca57bb102
?hl=en&

	Again, this had nothing whatsoever to do with whether the interpretation is
correct or not.

> Clearly at this point there's nothing to be gained from pursuing this
> any further. The 2.6 kernel has been out for too long; if it were to be
> "fixed" again it would just make life ugly for another group of people,
> and I don't want to write the autoconf tests to detect the
> flavor-of-the-week. We've wasted enough time arguing futilely over it,
> I'll stop.

	The problem is that this interpretation is simply incorrect and results in
maximally inefficient implementations.

	David Butenhof recently posted to comp.programming.threads and indicated
that disagreed with this implementation. That's about as close to
authoritative as you're likely to get.

	POSIX had no intention to constrain the scheduler to compel inefficient
behavior. In fact, they went out of their way to create the lightest
possible primitives.

	DS


