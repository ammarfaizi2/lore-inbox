Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263002AbREaDX3>; Wed, 30 May 2001 23:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263003AbREaDXT>; Wed, 30 May 2001 23:23:19 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:17419 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S263002AbREaDXJ>;
	Wed, 30 May 2001 23:23:09 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200105310323.f4V3N5I321727@saturn.cs.uml.edu>
Subject: Re: How to know HZ from userspace?
To: jlundell@pobox.com (Jonathan Lundell)
Date: Wed, 30 May 2001 23:23:05 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <p05100316b73b3f2e80e2@[10.128.7.49]> from "Jonathan Lundell" at May 30, 2001 05:24:37 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Lundell writes:
> At 5:07 PM -0700 2001-05-30, H. Peter Anvin wrote:

>>> If you now want to set those values from a userspace program / script in
>>>  a portable manner, you need to be able to find out of HZ of the currently
>>>  running kernel.
>>
>> Yes, but that's because the interfaces are broken.  The decision has
>> been that these values should be exported using the default HZ for the
>> architecture, and that it is the kernel's responsibility to scale them
>> when HZ != USER_HZ.  I don't know if any work has been done in this
>> area.

Nope.

HZ-derived values are not scaled in the /proc code.
The real value is not available to apps. (Linus said so)
People often change the HZ value.

Thus we have problems.

Maybe I'll post my disgusting hack. You _can_ get HZ out
of /proc if you know where to look. >:-)

> FWIW (perhaps not much in this context), the POSIX way is
> sysconf(_SC_CLK_TCK) POSIX sysconf is pretty useful for this
> kind of thing (not just HZ, either).

That does not report the real value. It reports the default.
