Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWIXThV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWIXThV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 15:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWIXThV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 15:37:21 -0400
Received: from smtpout.mac.com ([17.250.248.176]:45552 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751336AbWIXThT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 15:37:19 -0400
In-Reply-To: <ef6ldq$uup$1@taverner.cs.berkeley.edu>
References: <45150CD7.4010708@aknet.ru> <4516B2C8.4050202@aknet.ru> <4516B721.5070801@redhat.com> <4516C9D0.3080606@aknet.ru> <ef6ldq$uup$1@taverner.cs.berkeley.edu>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FE51C682-23F0-4BFE-AA3F-E3B74F9D6E3A@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
Date: Sun, 24 Sep 2006 15:37:16 -0400
To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 24, 2006, at 15:14:02, David Wagner wrote:
> Stas Sergeev  wrote:
>> Ulrich Drepper wrote:
>>> The consensus has been to add the same checks to mprotect.  They  
>>> were
>>> not left out intentionally.
>>
>> But how about the anonymous mmap with PROT_EXEC set?
>
> I'm curious about this, too.  ld-linux.so is a purely unprivileged
> program.  It isn't setuid root.  Can you write a variant of ld- 
> linux.so
> that reads an executable into memory off of a partition mounted  
> noexec and
> then begins executing that code?  (perhaps by using anonymous mmap  
> with
> PROT_EXEC or some other mechanism) It sure seems like the answer would
> be yes.  If so, I'm having a hard time understanding what guarantees
> noexec gives you.  Isn't the noexec flag just a speedbump that raises
> the bar a little but doesn't really prevent anything?

I seem to recall somewhere that it was possible to prevent anonymous  
memory from being mapped PROT_EXEC during or after being mapped  
PROT_WRITE; and that in fact your average SELinux-enabled system had  
such protections for everything but the Java binary and a few other  
odd programs.  If you can't ever execute any data blobs except those  
that came directly from a properly-secured SELinux-enabled filesystem  
it makes exploiting a server significantly harder.

Cheers,
Kyle Moffett

