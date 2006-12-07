Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030804AbWLGFjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030804AbWLGFjJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 00:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030736AbWLGFjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 00:39:09 -0500
Received: from 1wt.eu ([62.212.114.60]:1414 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030804AbWLGFjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 00:39:08 -0500
Date: Thu, 7 Dec 2006 06:39:01 +0100
From: Willy Tarreau <w@1wt.eu>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: vmscan.c:196: bad pmd (kernel 2.4.25)
Message-ID: <20061207053900.GC24090@1wt.eu>
References: <9a8748490612060022i25fc2617ya90e48c2e3c719d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490612060022i25fc2617ya90e48c2e3c719d1@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 06, 2006 at 09:22:29AM +0100, Jesper Juhl wrote:
> The following messages just showed up in dmesg on one of my servers.
> The server seems to be running fine but I would like to know if
> there's a real problem here or if the message is just noise.
>
> The server is running 2.4.25
> 
> vmscan.c:196: bad pmd 000001e3.
> vmscan.c:196: bad pmd 004001e3.
...
> vmscan.c:196: bad pmd 378001e3.
> vmscan.c:196: bad pmd 37c001e3.

I may be wrong, but to me it looks either like memory corruption
affecting one pgd, and by extension all of its pmds, or an old
bug in 2.4.25, but I don't recall seeing such a thing.

Anyway, I would personally reboot the server after such a thing, as I
really don't like it when VM is going mad.

Regards,
Willy

