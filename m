Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264709AbTFATSW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 15:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264710AbTFATSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 15:18:22 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:51718 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264709AbTFATSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 15:18:21 -0400
Subject: Re: warning: process 'update' used the obsolete bdflush...
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Stewart Smith <stewartsmith@mac.com>
Cc: Paul Rolland <rol@witbe.net>, LKML <linux-kernel@vger.kernel.org>,
       rol@as2917.net
In-Reply-To: <1B8F41EC-934B-11D7-B416-00039346F142@mac.com>
References: <1B8F41EC-934B-11D7-B416-00039346F142@mac.com>
Content-Type: text/plain
Message-Id: <1054495899.943.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 01 Jun 2003 21:31:40 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-05-31 at 11:34, Stewart Smith wrote:
> On Saturday, May 31, 2003, at 07:04  PM, Paul Rolland wrote:
> > When switching from 2.4.20 to 2.5.x (x being recent), I have this
> > message...
> >
> > What does this mean ?
> > 1 - I have no process named update running,
> > 2 - I can't find anything name update in /etc/rc.d/* recursively.
> 
> from fs/buffer.c:
> /*
>   * There are no bdflush tunables left.  But distributions are
>   * still running obsolete flush daemons, so we terminate them here.
>   *
>   * Use of bdflush() is deprecated and will be removed in a future 
> kernel.
>   * The `pdflush' kernel threads fully replace bdflush daemons and this 
> call.
>   */
> 
> I'd upgrade whatever package update comes from. I can't seem to find 
> that binary around on some of my systems, what distribution and version 
> are you running? Maybe it's time to upgrade.
> 
> Someone else might know specifics :)

"update" is not a program, but a kernel daemon that was superseded by
pdflush in 2.5 kernels. I just can't remember right know what caused
that warning, but it's similar to the SO_BSDCOMPAT warning that is
triggered when running bind.

