Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbTHYI5s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 04:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbTHYI5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 04:57:48 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.30]:3974 "EHLO
	mwinf0102.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261545AbTHYI5r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 04:57:47 -0400
From: Laurent =?iso-8859-1?q?Hug=E9?= <laurent.huge@wanadoo.fr>
Subject: Re: Personnal line discipline difficulties
Date: Mon, 25 Aug 2003 10:57:46 +0200
User-Agent: KMail/1.5.2
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308251057.46500.laurent.huge@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Lundi 25 Août 2003 10:42, vous avez écrit :
> > the result is not constant : sometimes, the line discipline receive the
> > 11 caracters (including the 0D and 0A termination), but most of the time,
> > it receive firstly 8 the 3 caracters. The *fp value is always 0 (so
> > there's no error !).
> That's not correct.  fp is an array of error characters, length "count".
> Each entry corresponds directly with each received character.
Yes. What I've meant by "always" is "at each caracter received". It equals
zero for everyone of them.
> In other words, it doesn't have any framing on  the group of characters it
> may hand you.
Do you mean that it's impossible for the tty_ldisc to know the size of what
the serial port received ? As I've told before, I've got no other way to know
it, so it's necessary to me (moreover, I'm trying to port an existing driver
from Windows to Linux, and the Windows serial driver gives accurately the
size of each PDU, so there must be a way).
--
Laurent Hugé.

