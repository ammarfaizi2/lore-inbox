Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266323AbTAYLvc>; Sat, 25 Jan 2003 06:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266330AbTAYLvb>; Sat, 25 Jan 2003 06:51:31 -0500
Received: from ns1.netroute.cz ([212.71.168.2]:48810 "HELO pop3.netroute.cz")
	by vger.kernel.org with SMTP id <S266323AbTAYLvb>;
	Sat, 25 Jan 2003 06:51:31 -0500
Date: Sat, 25 Jan 2003 13:00:38 +0100
From: Jan Hudec <bulb@ucw.cz>
To: David Wagner <daw@mozart.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Simple patches for Linux as a guest OS in a plex86 VM (please consider)
Message-ID: <20030125120038.GL693@vagabond>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	David Wagner <daw@mozart.cs.berkeley.edu>,
	linux-kernel@vger.kernel.org
References: <20030124154935.GB20371@elf.ucw.cz> <20030124171415.34636.qmail@web80310.mail.yahoo.com> <20030124180255.GF1099@marowsky-bree.de> <b0sqag$mau$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0sqag$mau$1@abraham.cs.berkeley.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2003 at 01:46:56AM +0000, David Wagner wrote:
> Lars Marowsky-Bree  wrote:
> >All alternatives I have seen to UML (plex, vmware, UMLinux) suck IMHO.
> 
> It seems plausible to expect that it might be easier to verify security
> in plex86-based approaches than it is to verify security in UML.

IIRC plex86 requires quite large module on the host. And I am not sure
it's does not have any privilegies. Umlinux requires no or very minimal
(thus easy to check for insecurities) patch to kernel and does not need
any privilegies (except the helper that sets up networking, but that's
pretty minimalistic too). If you properly chroot the umlinux process,
it's very secure (the skas mode will only work in chroot once it's made
to use syscall).

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
