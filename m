Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277382AbRJENrw>; Fri, 5 Oct 2001 09:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277383AbRJENrn>; Fri, 5 Oct 2001 09:47:43 -0400
Received: from geos.coastside.net ([207.213.212.4]:742 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S277382AbRJENrj>; Fri, 5 Oct 2001 09:47:39 -0400
Mime-Version: 1.0
Message-Id: <p0510031ab7e3681fe0b8@[207.213.214.37]>
In-Reply-To: <567F3237EED@vcnet.vc.cvut.cz>
In-Reply-To: <567F3237EED@vcnet.vc.cvut.cz>
Date: Fri, 5 Oct 2001 06:41:39 -0700
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Finegrained a/c/mtime was Re: Directory notification pr
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 3:27 PM -0700 2001-10-05, Petr Vandrovec wrote:
>On  5 Oct 01 at 14:15, Padraig Brady wrote:
>>  >Another advantage of using the real time instead of a counter is that
>>  >you can easily merge the both values into a single 64bit value and do
>>  >arithmetic on it in user space. With a generation counter you would need
>>  >to work with number pairs, which is much more complex.
>>  >
>>  ??
>>  if (file->mtime != mtime || file->gen_count != gen_count)
>>       file_changed=1;
>
>make needs comparing timestamps between two files. I cannot imagine
>how you can get this working (without network filesystem you can
>have global gen_count, but with network filesystem each server has
>its own gen_count... and using world-wide nanoseconds instead of world-wide
>gen_count looks much simpler to me ;-) )

Except for the world-wide-nanosecond-resolution synchronization problem....

Even keeping cycle-counter-based systems in sync within SMP systems 
seems problematical, depending on how the counters are implemented.
-- 
/Jonathan Lundell.
