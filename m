Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266995AbRG1TDK>; Sat, 28 Jul 2001 15:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266997AbRG1TDB>; Sat, 28 Jul 2001 15:03:01 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:56836 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266989AbRG1TCq>; Sat, 28 Jul 2001 15:02:46 -0400
Subject: Re: ext3-2.4-0.9.4
To: patl@cag.lcs.mit.edu (Patrick J. LoPresti)
Date: Sat, 28 Jul 2001 20:03:37 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <s5gsnfh80hw.fsf@egghead.curl.com> from "Patrick J. LoPresti" at Jul 28, 2001 12:46:51 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15QZNB-00082q-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> How does this scheme "risk delivering mail to the wrong person
> instead"?

With the fsync it looks ok for most cases. It depends on the actions of
a rename touching only one disk block - which of course it doesn't do. Even
so with the fsync on a sane fs I cant see that problem occuring

> If you have metadata journalling, all you need for this algorithm to
> work is to have rename() write to the journal before returning.  Is
> this true for any of the current journalling file systems on Linux?

Ext3 I believe so, Reiserfs I would assume so but Hans can answer
definitively
