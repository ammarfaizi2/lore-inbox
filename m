Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbTELWSp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 18:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbTELWSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 18:18:44 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:50221 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S262951AbTELWSn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 18:18:43 -0400
Subject: Re: PCMCIA 2.5.X sleeping from illegal context
From: Paul Fulghum <paulkf@microgate.com>
To: David Hinds <dhinds@sonic.net>
Cc: David Hinds <dahinds@users.sourceforge.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030512150618.B22527@sonic.net>
References: <1052775331.1995.49.camel@diemos>
	 <20030512150618.B22527@sonic.net>
Content-Type: text/plain
Organization: 
Message-Id: <1052743075.1467.6.camel@doobie>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 May 2003 07:37:56 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-12 at 17:06, David Hinds wrote:
> On Mon, May 12, 2003 at 04:35:32PM -0500, Paul Fulghum wrote:
> > 
> > So, are all the PCMCIA drivers supposed to be changed to not
> > release resources in the timer context? And if so, what
> > is the new convention?
> 
> yes.  The timers should be gotten rid of.
> 
> -- Dave

Just to be clear, in the device driver
CARD_REMOVAL handler, the release function
should now be called directly instead of
through the timer?

Thanks,
Paul

Paul Fulghum
paulkf@microgate.com


