Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVEPWtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVEPWtQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 18:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVEPWtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 18:49:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:44218 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261290AbVEPWtL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 18:49:11 -0400
Date: Mon, 16 May 2005 15:49:10 -0700
From: Greg KH <greg@kroah.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 7/8] ppc64: SPU file system
Message-ID: <20050516224909.GB13866@kroah.com>
References: <200505132117.37461.arnd@arndb.de> <200505170001.10405.arnd@arndb.de> <20050516222736.GA13350@kroah.com> <200505170022.57662.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505170022.57662.arnd@arndb.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 12:22:56AM +0200, Arnd Bergmann wrote:
> On Dinsdag 17 Mai 2005 00:27, Greg KH wrote:
> > Huh? ?We can handle syscalls in modules these days pretty simply. ?Look
> > at how nfs and others do it.
> 
> Well afaics, nfs works around this issue by having fs/nfsctl.o always
> as a builtin and abstract the calls through a file system using
> read/write. That would be Ben's idea again, i.e. not actually
> using a system call.
> 
> The only widely used module that I'm aware of ever implementing a system
> call was the TUX web accelerator that that used a hack in entry.S
> and its own dynamic registration.

Sorry, but I was thinking of the cond_syscall() stuff, to allow syscalls
in modules or code that just happens to not be built into the kernel.

thanks,

greg k-h
