Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281841AbRLQS2s>; Mon, 17 Dec 2001 13:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281854AbRLQS2i>; Mon, 17 Dec 2001 13:28:38 -0500
Received: from sushi.toad.net ([162.33.130.105]:14043 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S281841AbRLQS2S>;
	Mon, 17 Dec 2001 13:28:18 -0500
Subject: APM driver patch summary
From: Thomas Hood <jdthood@mail.com>
To: sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 17 Dec 2001 13:28:13 -0500
Message-Id: <1008613695.4859.84.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen:

A number of patches to the APM driver have been submitted to
lkml recently.  To summarize, these are (Did I miss any?):

Notify listener of suspend before notifying driver  (Russell King)
    http://marc.theaimsgroup.com/?l=linux-kernel&m=100819765228734&w=2
Fix idle handling                                   (Andreas Steinmetz)
    http://marc.theaimsgroup.com/?l=linux-kernel&m=100754277600661&w=2
Control apm idle calling by runtime parameter       (Andrej Borsenkow)
    http://marc.theaimsgroup.com/?l=linux-kernel&m=100852862320955&w=2

Each of these changes is required, IMHO.  However, the Russell King
patch probably won't apply without modifications.  Also, it needs to
be modified so that it will send a resume event to listeners in case
a driver rejects a suspend event that listeners have already
processed.  I think that this change should wait for 2.5, improvement
though it be, because it changes the behavior of the apm driver in
a significant way.

The other patches ought to apply cleanly to 2.4.17 and are independent
of Russell's changes, so ought to go into 2.4.18-pre, I think.  Can
you get them ready for Marcelo?

Cheers
Thomas Hood

