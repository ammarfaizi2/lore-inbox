Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262587AbVCWOpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbVCWOpZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 09:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbVCWOpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 09:45:24 -0500
Received: from smtp-out.tiscali.no ([213.142.64.144]:41484 "EHLO
	smtp-out.tiscali.no") by vger.kernel.org with ESMTP id S262398AbVCWOpC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 09:45:02 -0500
Subject: Re: forkbombing Linux distributions
From: Natanael Copa <mlists@tanael.org>
To: Max Kellermann <max@duempel.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050323142753.GA23454@roonstrasse.net>
References: <e0716e9f05032019064c7b1cec@mail.gmail.com>
	 <20050322112628.GA18256@roll>
	 <Pine.LNX.4.61.0503221247450.5858@yvahk01.tjqt.qr>
	 <20050323135317.GA22959@roonstrasse.net> <1111587814.27969.86.camel@nc>
	 <20050323142753.GA23454@roonstrasse.net>
Content-Type: text/plain
Date: Wed, 23 Mar 2005 15:44:58 +0100
Message-Id: <1111589098.27969.100.camel@nc>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-23 at 15:27 +0100, Max Kellermann wrote:
> On 2005/03/23 15:23, Natanael Copa <mlists@tanael.org> wrote:
> > On Wed, 2005-03-23 at 14:53 +0100, Max Kellermann wrote:
> > > The number of processes is counted per user, but CPU time and memory
> > > consumption is counted per process.
> > 
> > So limiting maximum number of processes will automatically limit CPU
> > time and memory consumption per user?
> 
> No. I was talking about RLIMIT_CPU and RLIMIT_DATA, compared to
> RLIMIT_NPROC. RLIMIT_NPROC limits the number of processes for that
> user, nothing else (slightly simplified explanation).

Yes, but if 
RLIMIT_NPROC is per user and RLIMIT_CPU is per proc

the theoretical CPU limit per user is RLIMIT_NPROC * RLIMIT_CPU. So if
you half the RLIMIT_NPROC you will half the theoretical maximum CPU
limit per user.

Same with memory.

I don't know if that really solves anything, but a misbehaving process
(fork bomb) would need to consume the double RAM or CPU to do the same
"damage" if RLIMIT_NPROC is halved.

--
Natanael Copa


