Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274789AbRJJFYE>; Wed, 10 Oct 2001 01:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274813AbRJJFXm>; Wed, 10 Oct 2001 01:23:42 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:4594
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S274803AbRJJFXi>; Wed, 10 Oct 2001 01:23:38 -0400
Date: Tue, 9 Oct 2001 22:24:03 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compile Filure on 2.4.10-ac10+preempt+smp
Message-ID: <20011009222403.A12825@mikef-linux.matchmail.com>
Mail-Followup-To: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20011009214655.A26663@mikef-linux.matchmail.com> <1002690949.862.233.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1002690949.862.233.camel@phantasy>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 01:15:25AM -0400, Robert Love wrote:
> On Wed, 2001-10-10 at 00:46, Mike Fedyk wrote:
> > Fail    2.4.10-ac10+preempt+smp
> > Success 2.4.10-ac10+preempt+up-apic+up-ipapic
> > Success 2.4.10-ac10+preempt
> > Success 2.4.10-ac10
> > 
> > Robert, can you do a test compile for smp just in case?
> 
> Ahh, yes.  Thank you for spotting this.  include/asm-i386/spinlock.h has
> two separate defines for spin_unlock and we only renamed one of them.  I
> guess you hit the conditional that used the other define...
>
> The attached patch fixes it.
>

Thank you.  Will compile now...

> > Also, I couldn't find any links to old patches on your web site...
> > [...]
> 
> I only keep around patches to the last official kernel, plus the latest
> -pre and -ac I patched.  Since the patch itself is being updated, its a
> pain to backport to older kernels.
>

No, I'm not asking for backport, just links to one version back just in case
the latest patch has a bug much like this...

I'd rather run one (working) version back than have to go to UP just to get
preempt...  Needless to say, I chose to keep smp.

Mike
