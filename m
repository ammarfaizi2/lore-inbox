Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265121AbTFMEFj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 00:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265122AbTFMEFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 00:05:39 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:13971 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S265121AbTFMEFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 00:05:39 -0400
Message-ID: <3EE9516B.3050502@pacbell.net>
Date: Thu, 12 Jun 2003 21:22:03 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: lode_leroy@hotmail.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 oops in ohci_hcd
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's odd ... the instructions there look like they're
at the start of the "if (ed->state == ED_IDLE) ..."
clause, and "ed" happens to be null.  (They're an
exact match for that code from one of my builds, and
the "ed_get + 0x55/0x210" is a close location match.)

Now, I can't see how "ed" could be null there, but
then maybe I wouldn't.  Easier to believe the bug
might be elsewhere.  Does it this reproduce for you?

If you provide additional info, make sure it includes
the part of "objdump -dr ohci-hcd.o" with ed_get().

- Dave





