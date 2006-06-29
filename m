Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932808AbWF2Jhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932808AbWF2Jhn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 05:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932804AbWF2Jhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 05:37:43 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:43154 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S932796AbWF2Jhm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 05:37:42 -0400
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "John Daiker" <jdaiker@osdl.org>,
       "John Hawkes" <hawkes@sgi.com>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Tony Luck" <tony.luck@gmail.com>, "Andrew Morton" <akpm@osdl.org>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       "Jack Steiner" <steiner@sgi.com>, "Dan Higgins" <djh@sgi.com>,
       "Jeremy Higdon" <jeremy@sgi.com>
Subject: Re: [PATCH] ia64: change usermode HZ to 250
References: <617E1C2C70743745A92448908E030B2A27FC5F@scsmsx411.amr.corp.intel.com>
From: Jes Sorensen <jes@sgi.com>
Date: 29 Jun 2006 05:37:40 -0400
In-Reply-To: <617E1C2C70743745A92448908E030B2A27FC5F@scsmsx411.amr.corp.intel.com>
Message-ID: <yq04py4i9p7.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Tony" == Luck, Tony <tony.luck@intel.com> writes:

Tony> Removing it completely might be better, it may force people to
Tony> look at how they are using HZ.  But there are probably many old
Tony> programs that have:

After reading through the discussion that was what I kept coming back
to.

Tony> #ifndef HZ #define HZ 60 #endif

Tony> So this won't catch them.

Tony> The ultimate safe solution might be:

Tony> #define HZ Fix your program to use sysconf(_SC_CLK_TCK)! \ (and
Tony> BTW, you should not include kernel headers)

Tony> Which is highly likely to cause a compile failure (but should at
Tony> least provide a clue to the user on what they should do).

You have my vote for that one. Anything else is just going to cause
those broken userapps to continue doing the wrong thing. We should
really do this on all archs though.

Cheers,
Jes
