Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278287AbRJWVFG>; Tue, 23 Oct 2001 17:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278293AbRJWVE5>; Tue, 23 Oct 2001 17:04:57 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7555 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S278287AbRJWVEm>; Tue, 23 Oct 2001 17:04:42 -0400
Date: Tue, 23 Oct 2001 17:05:13 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Werner Almesberger <wa@almesberger.net>, linux-kernel@vger.kernel.org
Subject: Re: [Q] pivot_root and initrd
In-Reply-To: <3BD5D886.8080206@zytor.com>
Message-ID: <Pine.LNX.3.95.1011023170019.21142A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2001, H. Peter Anvin wrote:

> Richard B. Johnson wrote:
> 
> > On Tue, 23 Oct 2001, Werner Almesberger wrote:
> > 
> > 
> >>H. Peter Anvin wrote:
> >>
> >>>The right thing is to get rid of the old initrd compatibility cruft,
> >>>but that's a 2.5 change.
> >>>
> >>Yes, change_root is obsolete (and relies on assumptions that are no
> >>longer valid in several cases), and there has been plenty of time for
> >>distributors to switch. An early funeral in 2.5 is a good idea.
> >>
> > 
> > Hmm. I need to install a SCSI driver, presumably from initrd
> > RAM disk as currently works. Will the new pivot-root be transparent?
> > 
> 
> 
> It's not transparent, you need to change your initrd.
> 
> 	-hpa


Presently, when /initrd/{ash.static} runs off the end of the
 /initrd/linuxrc script, the kernel tries to mount the root
defined for LILO. So I add some program that executes 'pivot-root'
instead of just letting the script run off the end?

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


