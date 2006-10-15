Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbWJOV1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbWJOV1s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 17:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbWJOV1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 17:27:48 -0400
Received: from bender.bawue.de ([193.7.176.20]:12745 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S1030285AbWJOV1r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 17:27:47 -0400
Date: Sun, 15 Oct 2006 22:27:46 +0100
From: Thiemo Seufer <ths@networkno.de>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: SYS_personality does not work correctly on mips(el)64
Message-ID: <20061015212746.GA25607@networkno.de>
References: <452EB653.7070604@aurel32.net> <20061013095206.GA4027@networkno.de> <4532A415.1080801@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <4532A415.1080801@aurel32.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aurelien Jarno wrote:
> Thiemo Seufer a écrit :
> >Aurelien Jarno wrote:
> >>Hi all,
> >>
> >>On mips(el), when doing multiple call to the syscall SYS_personality in 
> >>order to get the current personality (using 0xffffffff for the first 
> >>argument), on a 64-bit kernel, the second and subsequent syscalls are 
> >>failing. That works correctly with a 32-bit kernels and on other 
> >>architectures.
> >
> >That's caused by mis-handling broken sign extensions, see also
> >http://bugs.debian.org/380531.
> 
> I still got the exact same problem with this patch applied.

I works for me on a bcm91480b in big endian mode.


Thiemo
