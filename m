Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276312AbRJaX6f>; Wed, 31 Oct 2001 18:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276341AbRJaX60>; Wed, 31 Oct 2001 18:58:26 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:6383 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S276312AbRJaX52>;
	Wed, 31 Oct 2001 18:57:28 -0500
Date: Thu, 1 Nov 2001 01:28:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Hood <jdthood@mail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: apm suspend broken ?
Message-Id: <20011101012836.051ceba6.sfr@canb.auug.org.au>
In-Reply-To: <1004458698.4243.118.camel@thanatos>
In-Reply-To: <1004458698.4243.118.camel@thanatos>
X-Mailer: Sylpheed version 0.6.3claws18 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 30 Oct 2001 11:18:17 -0500 Thomas Hood <jdthood@mail.com> wrote:
> 
> If we were to use the write permission bit to control
> access, then it would not be necessary for the apm
> command to be setuid root to give the non-root user
> the ability to suspend the machine.  Instead we could
>     chgrp apm /dev/apm_bios
>     chmod g+w /dev/apm_bios
> and add the trusted user to the 'apm' group.
> 
> Am I missing something here?

No, you are not missing anything and I did consider the other part of your
patch, but was not brave enough to apply it when the kernel was "frozen".
However, the freeze lasted much longer than I expected :-)

I guess the original intention was that we would be able to add
capablilites to executable (much as we add setuid bits) and to users, but
that also seems to have taken a while to emerge.  I think, though, that I
have seen a PAM module for adding capabilities to users at login time.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
