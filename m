Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272677AbRISSWX>; Wed, 19 Sep 2001 14:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272528AbRISSWD>; Wed, 19 Sep 2001 14:22:03 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21010 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271645AbRISSVu>; Wed, 19 Sep 2001 14:21:50 -0400
Subject: Re: [PATCH] /dev/epoll update ...
To: dank@kegel.com (Dan Kegel)
Date: Wed, 19 Sep 2001 19:26:25 +0100 (BST)
Cc: cks@distributopia.com (Christopher K. St. John),
        linux-kernel@vger.kernel.org, davidel@xmailserver.org
In-Reply-To: <3BA8BBC9.EA1D0636@kegel.com> from "Dan Kegel" at Sep 19, 2001 08:37:45 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jm3F-0003TK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Stevens [UNPV1, in chapter on nonblocking accept] suggests that readiness
> notifications from the OS should only be considered hints, and that user
> programs should behave properly even if the OS feeds it false readiness
> events.  

For accept this is specifically and definitely true. A pending connection
can go away before you accept it. What happens then is rather OS specific -
BSD unix gives you a socket that has died - which can be handy and avoids
the problem but others don't all do the same
