Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264583AbUANTuM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 14:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264591AbUANTtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 14:49:13 -0500
Received: from ip5.searssiding.com ([216.54.166.5]:38792 "EHLO
	texas.encore.com") by vger.kernel.org with ESMTP id S264583AbUANTq4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 14:46:56 -0500
Message-ID: <40059CAD.FE57825E@compro.net>
Date: Wed, 14 Jan 2004 14:46:53 -0500
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-ert i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: VM_AREA size
References: <Pine.LNX.4.44.0401141827330.1711-100000@localhost.localdomain> <4005912F.9020008@zytor.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" wrote:
> 
> Hugh Dickins wrote:
> > On Wed, 14 Jan 2004, Mark Hounschell wrote:
> >
> >>What would the ramifications be of increasing VM_AREA size in
> >>include/asm-i386/page.h from 128mb to 256mb. What would be the proper way to
> >>increase this if the above isn't?
> >
> > I think you mean __VMALLOC_RESERVE?  For the most part it's straightforward
> > to bump it up.  _However_, that breaks boot loader assumptions about where
> > to load initrd, causing mayhem in that case (and initramfs?).  That's
> > second hand info: if I'm wrong or out-of-date, Peter is the authority
> > and will correct me; or try Google VMALLOC_RESERVE boot.
> >
> 
> I think it affects initramfs too.
> 
> It only affects boot loaders which don't support version 2.03 of the
> boot protocol; unfortunately that includes GRUB last I checked.
> 
> We really need a better dialog with the GRUB people, unfortunately at
> least I have unsuccessful in starting such a dialog.
> 
> GRUB, in particular, needs to report the boot loader ID they're using,
> plus support version 2.03 of the protocol.
> 
>         -hpa

Thanks guys. I "was" using grub I guess it's now back to lilo.

Mark
