Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbWJ3MTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWJ3MTQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 07:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWJ3MTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 07:19:16 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:26104 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751403AbWJ3MTP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 07:19:15 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH][RFC] KVM: prepare user interface for smp guests
Date: Mon, 30 Oct 2006 13:19:10 +0100
User-Agent: KMail/1.9.5
Cc: kvm-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <4544AD24.4040801@qumranet.com> <200610300101.11245.arnd@arndb.de> <4545C110.8080204@qumranet.com>
In-Reply-To: <4545C110.8080204@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610301319.10710.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 October 2006 10:08, Avi Kivity wrote:
> > Your concept of allocating
> > a new context on each open is already weird, but there have been other
> > examples of that before.
>
> Actually that seemed to me quite natural.

It's described in LDD2 and other books, but the traditional view is
still that one device node in /dev refers to an actual device or
at least something that acts like a device (e.g. /dev/null, dev/tty).

> BTW, what does lsof show for spufs users?  I thought lsof /dev/kvm would 
> be a good way to look for virtual machines.

It does what you expect. Since spufs is mounted, 'ls /spu/' shows you
the existing spu contexts, 'lsof /spu/*' shows you the tasks using those.

	Arnd <><
