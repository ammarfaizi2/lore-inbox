Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbTL2PuB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 10:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbTL2PuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 10:50:01 -0500
Received: from frankvm.xs4all.nl ([80.126.170.174]:58759 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S263472AbTL2Pt7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 10:49:59 -0500
Date: Mon, 29 Dec 2003 16:54:33 +0100
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: Rob Love <rml@ximian.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 can run with HZ==0!
Message-ID: <20031229155433.GA4475@janus>
Mail-Followup-To: Frank van Maarseveen <frankvm@xs4all.nl>,
	Rob Love <rml@ximian.com>, Arjan van de Ven <arjanv@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20031228230522.GA1876@janus> <1072691126.5223.5.camel@laptop.fenrus.com> <20031229125240.GA4055@janus> <1072711585.4294.8.camel@fur>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072711585.4294.8.camel@fur>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29, 2003 at 10:26:25AM -0500, Rob Love wrote:
> On Mon, 2003-12-29 at 07:52, Frank van Maarseveen wrote:
> 
> > Can you give me an example?
> 
> Sure, as this has already been done:
> 
> 	http://www.kernel.org/pub/linux/kernel/people/rml/variable-HZ/v2.4/

That looks more complete and its cleaner. When I needed the HZ patch I
deliberately didn't care about #ifdef __KERNEL__ in the header files. It
was a tmp hack anyway.

it doesn't contain the #if HZ==1000 fix in timer.c. I'm not sure if it
is that important and this one is broke since it fixes yet another HZ
value instead of all.

> 
> As you see, that has a ton of fixups, primarily to ensure that
> user-space is always exported jiffies in terms of USER_HZ==100.

I missed a two or three cases. Hoever, no sign of the tenfold size increase
or any fixes inside SCSI ioctls or firewall rules (netfilter code I presume).

Arjan, are you sure?

-- 
Frank
