Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWEUWUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWEUWUi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 18:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWEUWUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 18:20:38 -0400
Received: from ns.suse.de ([195.135.220.2]:25254 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932193AbWEUWUh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 18:20:37 -0400
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: IA32 syscall 311 not implemented on x86_64
Date: Mon, 22 May 2006 00:19:08 +0200
User-Agent: KMail/1.9.1
Cc: Ulrich Drepper <drepper@gmail.com>, Chris Wedgwood <cw@f00f.org>,
       dragoran <dragoran@feuerpokemon.de>, linux-kernel@vger.kernel.org
References: <44702650.30507@feuerpokemon.de> <20060521185000.GB8250@redhat.com> <20060521185610.GC8250@redhat.com>
In-Reply-To: <20060521185610.GC8250@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605220019.08902.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 May 2006 20:56, Dave Jones wrote:
> On Sun, May 21, 2006 at 02:50:00PM -0400, Dave Jones wrote:
>  > On Sun, May 21, 2006 at 11:35:12AM -0700, Ulrich Drepper wrote:
>  >  > On 5/21/06, Dave Jones <davej@redhat.com> wrote:
>  >  > >It's a glibc problem really.
>  >  > 
>  >  > It's not a glibc problem really.  The problem is this stupid error
>  >  > message in the kernel.  We rely in many dozens of places on the kernel
>  >  > returning ENOSYS in case a syscall is not implemented and we deal with
>  >  > it appropriately.  There is absolutely no justification to print these
>  >  > messages except perhaps in debug kernels.  IMO the sys32_ni_syscall
>  >  > functions should just return ENOSYS unless you select a special debug
>  >  > kernel.  One doesn't need the kernel to detect missing syscall
>  >  > implementations, strace can do this as well.
>  > 
>  > You make a good point.  In fact, given it's unthrottled, someone
>  > with too much time on their hands could easily fill up a /var
>  > just by calling unimplemented syscalls this way.

I never bought this argument because there are tons of printks in the kernel
that can be triggered by everybody.
 
> Actually it is kinda throttled, but only on process name.
> This patch just removes that stuff completely.
> (Also removes a bunch of trailing whitespace)

FF tree already has a different solution.

-Andi


> 
