Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261861AbSKCNsy>; Sun, 3 Nov 2002 08:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbSKCNsy>; Sun, 3 Nov 2002 08:48:54 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:39301 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261861AbSKCNsx>; Sun, 3 Nov 2002 08:48:53 -0500
Cc: Dax Kelson <dax@gurulabs.com>, Linus Torvalds <torvalds@transmeta.com>,
       Alexander Viro <viro@math.psu.edu>, "Theodore Ts'o" <tytso@mit.edu>,
       Rusty Russell <rusty@rustcorp.com.au>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "davej@suse.de" <davej@suse.de>
References: <20021103035017.GD18884@waste.org>
	<Pine.LNX.4.44.0211022052180.20616-100000@mooru.gurulabs.com>
	<20021103041055.GE18884@waste.org>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: Oliver Xymoron <oxymoron@waste.org>
Subject: Re: Filesystem Capabilities in 2.6?
Date: Sun, 03 Nov 2002 14:55:13 +0100
Message-ID: <87smyisqpq.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron <oxymoron@waste.org> writes:

> Generally, though there'd need to be an option to emulate, say, setgid
> mail.

Look at sucap and execcap available with libcap. Combine them and you
get a capability wrapper.

> On Sat, Nov 02, 2002 at 09:00:38PM -0700, Dax Kelson wrote:
>
>> Currently all capabilities are cleared when non-root app does a execp. 
>> This would need to be addressed.
>
> Hrmm. I thought the inherit mask dealt with that. 

You need the inherit set of the parent process _and_ the inherit set
of the binary to agree. For the latter you need some sort of fs
capabilities.

Regards, Olaf.
