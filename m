Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278042AbRKGJdx>; Wed, 7 Nov 2001 04:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278239AbRKGJdm>; Wed, 7 Nov 2001 04:33:42 -0500
Received: from lilac.csi.cam.ac.uk ([131.111.8.44]:28647 "EHLO
	lilac.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S278042AbRKGJdc>; Wed, 7 Nov 2001 04:33:32 -0500
Date: Wed, 7 Nov 2001 09:33:18 +0000
From: Christophe Rhodes <csr21@cam.ac.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: rth@twiddle.net, linux-kernel@vger.kernel.org
Subject: Re: SPARC and SA_SIGINFO signal handling
Message-ID: <20011107093318.A11078@cam.ac.uk>
In-Reply-To: <20011031094342.A27520@cam.ac.uk> <20011031.021131.74751566.davem@redhat.com> <20011103115900.B5984@twiddle.net> <20011103.155422.74749787.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011103.155422.74749787.davem@redhat.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 03, 2001 at 03:54:22PM -0800, David S. Miller wrote:
>    From: Richard Henderson <rth@twiddle.net>
>    Date: Sat, 3 Nov 2001 11:59:00 -0800
> 
>    On Wed, Oct 31, 2001 at 02:11:31AM -0800, David S. Miller wrote:
>    > The "register contents and so on" are in the sigcontext.
>    > We don't use ucontext on sparc32.
>    
>    In other words, you don't support SA_SIGINFO at all.
>    
> Is it required?  All the information that thing provides is
> determinable via other methods.

Sorry for the late response (I've been away); "required" is perhaps
putting it strongly, because as you say the information is there,
somewhere. However, it would be nice to have, as standardized, that
the third argument to the sa_sigaction handler be castable to a
ucontext_t, as this would make porting signal-handling code between
Linux flavours much easier.

Cheers,

Christophe
-- 
Jesus College, Cambridge, CB5 8BL                           +44 1223 510 299
http://www-jcsu.jesus.cam.ac.uk/~csr21/                  (defun pling-dollar 
(str schar arg) (first (last +))) (make-dispatch-macro-character #\! t)
(set-dispatch-macro-character #\! #\$ #'pling-dollar)
