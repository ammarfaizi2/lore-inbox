Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbTKGWZy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbTKGWZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:25:10 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:31756 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264353AbTKGOLf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 09:11:35 -0500
Date: Fri, 7 Nov 2003 09:01:01 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Soeren Sonnenburg <kernel@nn7.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: loopback device + crypto = crash on 2.6.0-test7 ?
In-Reply-To: <1067411342.1574.11.camel@localhost>
Message-ID: <Pine.LNX.3.96.1031107085651.20991A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Oct 2003, Soeren Sonnenburg wrote:

> I wanted to setup a blowfish encrypted file which is then mounted via
> loopback. So I did:
> 
> losetup -e blowfish /dev/loop0 /file
> Password:
> mkfs -t ext3 /dev/loop0
> mount /dev/loop0 /mnt
> <error unknown fs type>
> <from here something was seriously broken... could not reboot anymore>

Did you pre-create the file? I've been doing something quite similar since
about test6, although I use ext2 and aes I don't suspect that matters. But
I did preallocate the file with dd first. I assume you did that, since you
don't give a size in mkfs, but better to mention it.

> 
> system is:
> Linux no 2.6.0-test7 #8 Sun Oct 26 17:00:49 CET 2003 ppc GNU/Linux
> 
> (benh rsync tree)

I've run both dead stock test releases, -mm, and most recently a mix of
Nick and Con scheduler and io patches.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

