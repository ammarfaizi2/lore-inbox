Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288801AbSANTPY>; Mon, 14 Jan 2002 14:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288959AbSANTOH>; Mon, 14 Jan 2002 14:14:07 -0500
Received: from mnh-1-25.mv.com ([207.22.10.57]:47111 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S288969AbSANTN3>;
	Mon, 14 Jan 2002 14:13:29 -0500
Message-Id: <200201141914.OAA04168@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: mingo@elte.hu
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Davide Libenzi <davidel@xmailserver.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: The O(1) scheduler breaks UML 
In-Reply-To: Your message of "Mon, 14 Jan 2002 10:40:16 +0100."
             <Pine.LNX.4.33.0201140954300.2248-100000@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 14 Jan 2002 14:14:34 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mingo@elte.hu said:
> i'd suggest to find some other solution for UML, besides signals.

You suggest implementing interrupts with something other than signals?  What
else is there?

In any case, I stuck a little kludge in _switch_to which checks for pending
SIGIO and, if there is one, hits the incoming process with a SIGIO.  This
seems to do the trick.

				Jeff

