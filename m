Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267769AbUHVXHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267769AbUHVXHW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 19:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267783AbUHVXHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 19:07:22 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:49031 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S267769AbUHVXGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 19:06:31 -0400
Date: Mon, 23 Aug 2004 08:06:33 +0900
From: Itsuro Oda <oda@valinux.co.jp>
To: Tonnerre <tonnerre@thundrix.ch>
Subject: Re: [RFC]Kexec based crash dumping
Cc: linux-kernel@vger.kernel.org, oda@valinux.co.jp
In-Reply-To: <20040820142840.GD16660@thundrix.ch>
References: <20040819083333.76F4.ODA@valinux.co.jp> <20040820142840.GD16660@thundrix.ch>
Message-Id: <20040823075315.7713.ODA@valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.10.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> areas? Will the booting of the dump kernel simply fail?
yes.

The pre-allocation area used by the dump kernel is set 
write protection after loading the dump kernel. It protects
from writing through virtual address space, but does not
protect through DMA writing.

Thank you

On Fri, 20 Aug 2004 16:28:40 +0200
Tonnerre <tonnerre@thundrix.ch> wrote:

> Salut,
> 
> On Thu, Aug 19, 2004 at 08:45:00AM +0900, Itsuro Oda wrote:
> > - prepare a kernel which does only dump real memory to block
> >   device. ("dump mini kernel")
> > - pre-allocate the memory (4MB is enough) used by the dump mini
> >   kernel and pre-load the dump mini kernel.
> > - when crash occur exec the dump mini kernel.
> > - the dump mini kernel stands in and only uses pre-allocated
> >   area.
> 
> One question, what  happens in your concept when  some stubborn zombie
> kernel driver  (say Nvidia) comes  along and overwrites  random memory
> areas? Will the booting of the dump kernel simply fail?
> 
> 			    Tonnerre

-- 
Itsuro ODA <oda@valinux.co.jp>

