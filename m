Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263627AbTKKPb2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 10:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbTKKPb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 10:31:28 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:47005 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S263627AbTKKPb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 10:31:26 -0500
Message-ID: <3FB100CB.1010209@softhome.net>
Date: Tue, 11 Nov 2003 16:31:23 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
References: <Qvw7.5Qf.9@gated-at.bofh.it> <QH4e.eV.3@gated-at.bofh.it> <3FB0EE0E.6090103@softhome.net> <20031111150256.GA13283@bitwizard.nl>
In-Reply-To: <20031111150256.GA13283@bitwizard.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff wrote:
> 
> Fine. For compatibilty we'll leave "sendfile" in place. But if somehow
> someone builds a filesystem which cannot use the pagecache, then
> "sendfile" will fail. Or if somehow we manage to get the socket hooked
> up to something else (*). Either CVS needs to handle that case
> internally, or it will fail. In the first case, that causes extra code
> in lots of applications that want to continue to work, in the latter
> case, it's bad.
> 

   I beleive - if you really want to have something like this - you need 
to go to e.g. nfs/coda/smbfs developers and talk with them: how it can 
be implemented in this situations.

   Implement it with ioctl() - to really see make it sense or it just 
complicates things enourmously. Actually given networked file systems 
could be just NOT capable of this kind of operation at all.

   Insisting on new syscall is silly: syscall is interface - it has 
nothing to do with functionality. Ocasionally syscalls are used to 
access functionality ;-)  So start from functionality first. Syscall (or 
whatever interface will fit better) can be implemented in 15 minutes any 
time after functionality is in place.

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  "... and for $64000 question, could you get yourself       |_|*|_|
    vaguely familiar with the notion of on-topic posting?"   |_|_|*|
                                 -- Al Viro @ LKML           |*|*|*|

