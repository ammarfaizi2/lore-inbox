Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277148AbRJQUcP>; Wed, 17 Oct 2001 16:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277151AbRJQUcF>; Wed, 17 Oct 2001 16:32:05 -0400
Received: from t2.redhat.com ([199.183.24.243]:18672 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S277148AbRJQUbx>; Wed, 17 Oct 2001 16:31:53 -0400
Message-ID: <3BCDEAD9.DEC2415F@redhat.com>
Date: Wed, 17 Oct 2001 21:32:25 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-4smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: pierre@lineo.com, linux-kernel@vger.kernel.org
Subject: Re: GPLONLY kernel symbols???
In-Reply-To: <Pine.LNX.4.10.10110171126480.5821-100000@innerfire.net> <3BCDE77F.D1B164A@lineo.com> <200110171934.f9HJY8w01260@adsl-209-76-109-63.dsl.snfc21.pacbell.net> <3BCDF89C.32916516@lineo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> The real question is whether or not the kernel
> code should be encumbered with legal issues. The
> fact that this or that piece of code is or isn't GPL
> should be in a text file attached to the kernel
> tarball. This sort of thing has no place in the
> code : countless patches with useful code that
> should live in userland have been (rightfully)
> rejected as having no place inside the kernel, why
> should code that deals with legal issues and is
> pretty much dead weight from a technical standpoint
> be allowed in ?

It's not legal issues. It's 1 integer and 1 sysctl variable
that allow easy filtering of nvidia and other bugreports.
THAT is the purpose of "tainted". Show in the oops that 
binary only modules are used. (this assumes all gpl modules to 
have a MODULE_LICENSE() line which doesn't result in code
and isn't loaded into kernel memory; recent kernels have over 99% 
coverage for in-kernel drivers and lots of external drivers have
it as well).
