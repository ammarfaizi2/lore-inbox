Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbQLHAcV>; Thu, 7 Dec 2000 19:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129392AbQLHAcM>; Thu, 7 Dec 2000 19:32:12 -0500
Received: from mailhost.talkware.net ([216.5.131.131]:25094 "EHLO
	mailhost.talkware.net") by vger.kernel.org with ESMTP
	id <S129352AbQLHAbw>; Thu, 7 Dec 2000 19:31:52 -0500
Message-ID: <3A3024D4.EDA13485@talkware.net>
Date: Thu, 07 Dec 2000 18:01:24 -0600
From: Eric Estabrooks <estabroo@talkware.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: cyrix III by via
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not a subscriber to this list, but I thought this was important
information (which you might already have).

The cyrixIII chips by via have the centaur vendor id which causes the
identify_cpu call in arch/i386/kernel/setup.c to fail.  It is probably
reasonable for it to have the centaur id as via owns centaur as well.  I
just replaced the centaur_model call with the cyrix_model one, but I
know that I am using a cyrix chip.

A test probably needs to be added in the centaur_model section to test
for the cyrixIII in disguise.

The error is a general protection fault.

Sorry if this is old hat,

Eric Estabrooks
    estabroo@talkware.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
