Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263067AbTDBRWP>; Wed, 2 Apr 2003 12:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263069AbTDBRWP>; Wed, 2 Apr 2003 12:22:15 -0500
Received: from smtpde02.sap-ag.de ([155.56.68.170]:60607 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S263067AbTDBRWO>; Wed, 2 Apr 2003 12:22:14 -0500
From: Christoph Rohland <cr@sap.com>
To: CaT <cat@zip.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, tomlins@cam.org,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
Organisation: Development SAP J2EE Engine
Date: Wed, 02 Apr 2003 19:33:05 +0200
In-Reply-To: <20030402144432.GB536@zip.com.au> (CaT's message of "Thu, 3 Apr
 2003 00:44:32 +1000")
Message-ID: <ovadf8ls8e.fsf@sap.com>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) XEmacs/21.4 (Native Windows TTY
 Support (Windows), cygwin32)
References: <Pine.LNX.4.44.0304011734370.1503-100000@localhost.localdomain>
	<ovd6k5l60d.fsf@sap.com> <20030402144432.GB536@zip.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Apr 2003, cat@zip.com.au wrote:
> Sounds like what you want is a dynamically resizing tmpfs based on
> the amount of memory (ram+swap) available. That's a much bigger
> goose to fry I believe.
> 
> Now, even if the percentile patch took into account swap, you'd
> still need to remount tmpfs in order to get it to take into account
> of any swap you add on the fly.

No, that's why I said you would need hooks into swapon and
swapoff. Then it would adjust on the fly. Else it's useless from the
usability point of view. With these hooks it's easy to do.

>> could add much saner defaults for /dev/shm or even use it for /tmp.
> 
> I use it for /tmp now just fine. :) It's sized at 63% of 256MB of
> RAM.

And I have set it to 400MB on a 256MB box just fine ;-) How could you
do these two setup generally without knowing your hardware. 20MB tmpfs
on a 40MB machine can be a desaster btw.

Greetings
		Christoph


