Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288149AbSBOMVj>; Fri, 15 Feb 2002 07:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288611AbSBOMVU>; Fri, 15 Feb 2002 07:21:20 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:22800 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S288149AbSBOMVJ>; Fri, 15 Feb 2002 07:21:09 -0500
Date: Fri, 15 Feb 2002 13:20:44 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: David Howells <dhowells@redhat.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linus Torvalds <torvalds@transmeta.com>, <davidm@hpl.hp.com>,
        "David S. Miller" <davem@redhat.com>, <anton@samba.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] move task_struct allocation to arch 
In-Reply-To: <23458.1013773072@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.33.0202151310510.713-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 15 Feb 2002, David Howells wrote:

> > That wouldn't be a problem, if ia32 added the needed infrastructure to
> > calculate the structure offsets.
>
> But the offsets aren't fixed. The task structure does not lie adjacent to the
> thread_info structure.

That's not the problem, I meant this sentence: "This led to Linus
requesting that everything that entry.S needs to access be separated out
into another structure." Splitting the task structure and the stack page
is fine. Keeping the most important fields in the stack page is fine too,
if the architecture requires it. But the decision what goes into
thread_info, should not be made only to avoid access to task_struct from
entry.S.

bye, Roman

