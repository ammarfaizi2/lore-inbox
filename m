Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbVLFAll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbVLFAll (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbVLFAlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:41:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49578 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751570AbVLFAe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:34:59 -0500
Subject: Re: Linux in a binary world... a doomsday scenario
From: David Woodhouse <dwmw2@infradead.org>
To: Tim Bird <tim.bird@am.sony.com>
Cc: arjan@infradead.org, andrew@walrond.org, linux-kernel@vger.kernel.org
In-Reply-To: <4394D396.1020102@am.sony.com>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	 <200512051826.06703.andrew@walrond.org>
	 <1133817575.11280.18.camel@localhost.localdomain>
	 <1133817888.9356.78.camel@laptopd505.fenrus.org>
	 <1133819684.11280.38.camel@localhost.localdomain>
	 <4394D396.1020102@am.sony.com>
Content-Type: text/plain
Date: Tue, 06 Dec 2005 00:34:55 +0000
Message-Id: <1133829295.11280.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-05 at 15:56 -0800, Tim Bird wrote:
> If the GPL covers interface linkages (whether static or
> dynamic) then EXPORT_SYMBOL_GPL is redundant.  If it does
> not, in all cases, then EXPORT_SYMBOL_GPL is, as
> an extension to GPL, therefore a GPL violation.

You seem to be agreeing with me to a certain extent. What I'm saying is
that there _can_ be no difference between EXPORT_SYMBOL() and
EXPORT_SYMBOL_GPL(). We might as well stick to one or the other.

As you say -- if the GPL covers modules, EXPORT_SYMBOL_GPL is redundant.
If it does not, then EXPORT_SYMBOL_GPL in itself is a GPL violation.

The point of EXPORT_SYMBOL_GPL, however, is that it is a technical
restriction which needs to be circumvented in order to load a non-GPL
module. That does affect the outcome of a court case when the licence is
violated, and that's why I think we should it throughout.

However, if your lawyers promise you that the court won't rule that the
GPL covers modules, then you have nothing to fear from EXPORT_SYMBOL_GPL
because (according to your lawyers) the court will rule that it means no
more than EXPORT_SYMBOL does. That's your risk to take; there's no
reason why we should use EXPORT_SYMBOL _anywhere_ until/unless a court
actually makes that ruling. 

-- 
dwmw2

