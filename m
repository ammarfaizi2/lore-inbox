Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279723AbRJYIJT>; Thu, 25 Oct 2001 04:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279729AbRJYIJF>; Thu, 25 Oct 2001 04:09:05 -0400
Received: from smtp-rt-8.wanadoo.fr ([193.252.19.51]:33225 "EHLO
	lantana.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S279723AbRJYII4>; Thu, 25 Oct 2001 04:08:56 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, Patrick Mochel <mochel@osdl.org>,
        Jonathan Lundell <jlundell@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Thu, 25 Oct 2001 10:09:07 +0200
Message-Id: <20011025080907.28926@smtp.wanadoo.fr>
In-Reply-To: <20011025080342.1865@smtp.wanadoo.fr>
In-Reply-To: <20011025080342.1865@smtp.wanadoo.fr>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>In this case, "sg" could add itself when opened, and eventually cause
>sleep requests to be rejected for example.

Well, looks like Linus won't let this one pass ;) A /proc/sgbusy would
eventually be ok, but I'd rather start defining a proper interface
to the PM daemon in userland for apps to request that the machine
doesn't go to sleep. That would be used, among other things, by
CD burners & firmware updaters. No need to hack thousands of apps,
I beleive if we get a patch implementing support for that in cdrecord,
then all burners software will magically start getting it ;)

Ben.




