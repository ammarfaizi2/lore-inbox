Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267798AbUHRVXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267798AbUHRVXV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 17:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267760AbUHRVWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 17:22:37 -0400
Received: from mail.inter-page.com ([12.5.23.93]:39183 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S267798AbUHRVWO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 17:22:14 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'DervishD'" <disposable1@telefonica.net>
Cc: "'Linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: setproctitle
Date: Wed, 18 Aug 2004 14:21:36 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAvgXAGuUD20CaadqFIQ1OWQEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
In-Reply-To: <20040818085850.GW11200@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org]
On Behalf Of William Lee Irwin III
Sent: Wednesday, August 18, 2004 1:59 AM
To: DervishD
Cc: Linux-kernel
Subject: Re: setproctitle

> The command-line arguments are being fetched from the process address
> space, i.e. simply editing argv[] in userspace will have the desired
> effect. Though this code is butt ugly.

What prevents overrun when updating arg[]?

What happens to all the little ps (etc.) programs when I munge together a *really*
*long* title?

Can the entirety of arg[] be moved to a newly allocated region, if so how?  (e.g.
wouldn't I have to have access to overwrite mm->arg_start etc?

I'd prefer a setthreadtitle(char * new_title) such that the individual threads in a
process (including the master thread, and so setproctitle() function is covered)
could be re-titled to declare their purposes.  It would make debugging and logging a
lot easier and/or more meaningful sometimes. 8-)

It would also let the system preserve the original invocation and args for the
lifetime of the process to prevent masquerading.  You know, by default the title is
the args, but the set operation would build the new title in a new kernel-controlled
place and move the pointer.

I'd be willing to work on this if there is interest.

Rob.





