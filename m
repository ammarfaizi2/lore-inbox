Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269965AbRHEOwP>; Sun, 5 Aug 2001 10:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269966AbRHEOwG>; Sun, 5 Aug 2001 10:52:06 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:36101 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S269965AbRHEOvt>;
	Sun, 5 Aug 2001 10:51:49 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] /proc/ksyms change for IA64 
In-Reply-To: Your message of "Mon, 06 Aug 2001 00:02:51 +1000."
             <E15TOUV-00012J-00@localhost> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Aug 2001 00:51:53 +1000
Message-ID: <27864.997023113@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Aug 2001 00:02:51 +1000, 
Rusty Russell <rusty@rustcorp.com.au> wrote:
>In message <13470.996995793@ocs3.ocs-net> you write:
>> >Eewwww....
>> >
>> >	How about just adding /proc/ksyms-ia64 with the code pointers
>> >which contains the ia64 code addresses required by ksymoops and
>> >debuggers.  These are, after all, less vital than insmod.
>> 
>> That requires changes to every kernel debugger, oops decoder etc.  I
>> don't control all of Linux debugging yet ;).  It is also more work
>> because it requires kernel changes as well as lots of user space.
>
>For ia64 only.  IMHO, that's a better line to draw.

My approach preserves the notion that a ksyms entry points to the data
or code, changing the function descriptor to a different name in ksyms.
Your approach breaks that notion and introduces a special case for ia64
ksyms.  My approach only needs changes to modutils.  Your approach
requires changes to the kernel and to every utility that understands
ksyms.  Guess which approach I am doing?

