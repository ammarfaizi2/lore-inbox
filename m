Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265577AbRGCHj2>; Tue, 3 Jul 2001 03:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266457AbRGCHjS>; Tue, 3 Jul 2001 03:39:18 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:33392 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S265577AbRGCHjM>; Tue, 3 Jul 2001 03:39:12 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Sean Hunter <sean@dev.sportingbet.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: modules and 2.5 
In-Reply-To: Your message of "Tue, 03 Jul 2001 03:24:26 -0400."
             <3B41732A.DD617268@mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Jul 2001 17:39:02 +1000
Message-ID: <2422.994145942@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Jul 2001 03:24:26 -0400, 
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>> On Tue, 3 Jul 2001 07:50:50 +0100,
>> Sean Hunter <sean@dev.sportingbet.com> wrote:
>> >Does this defeat my favourite module-related gothcha, that the machine panics
>> >if I have (say) a scsi driver builtin to the kernel and the same driver tries
>> >to load itself as a module?
>
>If this occurs in 2.4 it is a bug and should be fixed in 2.4.

Human error.  Create a new kernel with something built in which used to
be a module and forget to make modules_install, so the code is in the
kernel and in /lib/modules.  Then do an explicit insmod, if probing
does not fail the module load then oops is all she wrote.  One of the
reasons I changed modules_install to erase the old directory first was
to minimize this problem, but humans can still stuff it up.  AFAICT it
cannot be fixed in 2.4 because there is no identifier for which
"modules" are included in the kernel.

