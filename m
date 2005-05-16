Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbVEPWl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbVEPWl0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 18:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbVEPWlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 18:41:16 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:57854 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S261965AbVEPWjH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 18:39:07 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 7/8] ppc64: SPU file system
Date: Tue, 17 May 2005 00:22:56 +0200
User-Agent: KMail/1.7.2
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <200505132117.37461.arnd@arndb.de> <200505170001.10405.arnd@arndb.de> <20050516222736.GA13350@kroah.com>
In-Reply-To: <20050516222736.GA13350@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200505170022.57662.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dinsdag 17 Mai 2005 00:27, Greg KH wrote:
> Huh?  We can handle syscalls in modules these days pretty simply.  Look
> at how nfs and others do it.

Well afaics, nfs works around this issue by having fs/nfsctl.o always
as a builtin and abstract the calls through a file system using
read/write. That would be Ben's idea again, i.e. not actually
using a system call.

The only widely used module that I'm aware of ever implementing a system
call was the TUX web accelerator that that used a hack in entry.S
and its own dynamic registration.

	Arnd <><
