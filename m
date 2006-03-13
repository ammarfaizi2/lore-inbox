Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWCMTbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWCMTbs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 14:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWCMTbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 14:31:48 -0500
Received: from smtp-2.llnl.gov ([128.115.3.82]:61943 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id S932334AbWCMTbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 14:31:47 -0500
From: Dave Peterson <dsp@llnl.gov>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] EDAC: core EDAC support code
Date: Mon, 13 Mar 2006 11:31:14 -0800
User-Agent: KMail/1.5.3
Cc: Greg KH <greg@kroah.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, alan@redhat.com,
       gregkh@kroah.com, Doug Thompson <dthompson@lnxi.com>,
       bluesmoke-devel@lists.sourceforge.net
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <200603101757.00060.dsp@llnl.gov> <1142061512.3055.2.camel@laptopd505.fenrus.org>
In-Reply-To: <1142061512.3055.2.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603131131.14883.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 March 2006 23:18, Arjan van de Ven wrote:
> > ok, perhaps things might look something like this?
>
> <snip>
>
> sounds like overdesign to me ;)

Hmm... ok :)  I don't want to suggest that Linux's hardware error
handling mechanism should be "all of the above".  Rather my intent is
this:

    - To summarize some previously mentioned options for error
      handling APIs, and mention a couple more ideas.  More discussion
      is needed to decide exactly what we want.

    - To suggest that drivers and hardware subsystems may want some
      flexibility in how they detect and process errors.  (However,
      there is also such a thing as too much flexibility; EDAC should
      create a certain amount of uniformity)

    - To state a couple of motivations for keeping error checking
      (i.e. reading error info from registers and clearing the
      registers) logically separate from error handling (i.e. doing
      something with the info obtained from the registers)

Another thing to think about: If EDAC is going to collect error info
from subsystems and drivers, it needs some sort of API that supports
this.  Although I don't think this requires anything fancy, it still
needs some discussion.

I'd be curious to read more discussion/ideas about error handling APIs
(and see some patches that illustrate the ideas).

Dave
