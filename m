Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316783AbSFUU1J>; Fri, 21 Jun 2002 16:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316786AbSFUU1I>; Fri, 21 Jun 2002 16:27:08 -0400
Received: from holomorphy.com ([66.224.33.161]:62147 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316783AbSFUU1E>;
	Fri, 21 Jun 2002 16:27:04 -0400
Date: Fri, 21 Jun 2002 13:26:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: Erik McKee <camhanaich99@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUGREPORT] kernel BUG in page_alloc.c:141!
Message-ID: <20020621202631.GD22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Kai Germaschewski <kai-germaschewski@uiowa.edu>,
	Erik McKee <camhanaich99@yahoo.com>, linux-kernel@vger.kernel.org
References: <20020621200613.GB22961@holomorphy.com> <Pine.LNX.4.44.0206211521130.14251-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0206211521130.14251-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2002 at 12:15:28PM -0700, Erik McKee wrote:
>>> Booted 2.5.24, and it ran fine for sometime, before it dead(live) locked,
>>> causing a reboot.  Attempts to reboot were met with the following bug
>>> immediatly after calibrating delay loop, which equates out to an
>>> if(bad_range(buddy1,zone)) BUG; in __free_pages_ok:

On Fri, 21 Jun 2002, William Lee Irwin III wrote:
>> This looks odd. Can you by any chance disassemble the parts before this?
>> Or better yet, reproduce it with a kernel compiled with -g and objdump
>> --source --disassemble vmlinux to get the disassembly of __free_pages_ok()?

On Fri, Jun 21, 2002 at 03:23:13PM -0500, Kai Germaschewski wrote:
> "make mm/page_alloc.lst" may simplify this task. However, the usage of the
> various macros seems to confuse gcc -g / objdump somewhat, so the output
> isn't as clear as it could be.
> --Kai

I've had to work around that before, I'll probably still be able to
recognize it. It's still a royal PITA.

Cheers,
Bill
