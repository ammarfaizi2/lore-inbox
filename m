Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964937AbVLFJ4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbVLFJ4y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 04:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbVLFJ4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 04:56:54 -0500
Received: from baythorne.infradead.org ([81.187.2.161]:62399 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S964937AbVLFJ4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 04:56:54 -0500
Subject: Re: Linux in a binary world... a doomsday scenario
From: David Woodhouse <dwmw2@infradead.org>
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: Tim Bird <tim.bird@am.sony.com>, Andrea Arcangeli <andrea@suse.de>,
       arjan@infradead.org, andrew@walrond.org, linux-kernel@vger.kernel.org
In-Reply-To: <1133861208.10158.34.camel@tara.firmix.at>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	 <200512051826.06703.andrew@walrond.org>
	 <1133817575.11280.18.camel@localhost.localdomain>
	 <1133817888.9356.78.camel@laptopd505.fenrus.org>
	 <1133819684.11280.38.camel@localhost.localdomain>
	 <4394D396.1020102@am.sony.com> <20051206005341.GN28539@opteron.random>
	 <4394E750.8020205@am.sony.com>  <1133861208.10158.34.camel@tara.firmix.at>
Content-Type: text/plain
Date: Tue, 06 Dec 2005 09:56:43 +0000
Message-Id: <1133863003.4136.42.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-06 at 10:26 +0100, Bernd Petrovitsch wrote:
> Lots of patent attorneys and average law persons gives advices on
> technical stuff (where they effectively have no idea what's really
> going on) so it *must* be legitimate the other way 'round.

I think Tim's right to suggest that we shouldn't be giving that kind of
advice. Especially when we are so inconsistent about it, and when our
opinion is irrelevant.

If your lawyers advise you that using a given symbol from your
binary-only module was OK when it was exported with EXPORT_SYMBOL, then
that situation _cannot_ change when we switch it to EXPORT_SYMBOL_GPL;
we're simply not _allowed_ to impose additional restrictions. The only
thing that changes is the _amount_ of trouble you are in if the court
disagrees with your lawyers, because now you've actively circumvented a
technical protection measure in order to violate our copyright.

That protection is the only real difference between EXPORT_SYMBOL() and
EXPORT_SYMBOL_GPL(), once you realise that it can't change the legal
status of the export in question, and you discount the 'advice' which we
shouldn't be giving anyway.

Since the protection of EXPORT_SYMBOL_GPL() is only relevant if you are
actually found to be in violation of the licence, we might as well be
using it for all symbols. If you fervently believe that binary-only
modules are legal, you can still go ahead and use them. It's just that
you'd better be _very_ sure of yourself before you do so, because if you
_do_ lose in court you'll be getting more than a slap on the wrist.

By switching in the opposite direction, Linus is actively weakening our
position, and I object very strongly to that.

-- 
dwmw2


