Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278800AbRKEBmw>; Sun, 4 Nov 2001 20:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280095AbRKEBmn>; Sun, 4 Nov 2001 20:42:43 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:12165 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S278800AbRKEBm2>; Sun, 4 Nov 2001 20:42:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Christian Laursen <xi@borderworlds.dk>
Subject: Re: Ext2 directory index, updated
Date: Mon, 5 Nov 2001 02:43:28 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011104022659Z16995-4784+750@humbolt.nl.linux.org> <m3hesatcgq.fsf@borg.borderworlds.dk>
In-Reply-To: <m3hesatcgq.fsf@borg.borderworlds.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011105014225Z17055-18972+38@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 4, 2001 11:09 pm, Christian Laursen wrote:
> Daniel Phillips <phillips@bonn-fries.net> writes:
> 
> > ***N.B.: still for use on test partitions only.***
> 
> It's the first time, I've tried this patch and I must say, that
> the first impression is very good indeed.
> 
> I took a real world directory (my linux-kernel MH folder containing
> roughly 115000 files) and did a 'du -s' on it.
> 
> Without the patch it took a little more than 20 minutes to complete.
> 
> With the patch, it took less than 20 seconds. (And that was inside uml)

Which kernel are you using?  From 2.4.10 on ext2 has an accelerator in 
ext2_find_entry - it caches the last lookup position.  I'm wondering how that 
affects this case.

--
Daniel
