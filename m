Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268769AbUJUMAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268769AbUJUMAf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 08:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268890AbUJUL5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 07:57:45 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:42506 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261610AbUJULx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 07:53:29 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Mildred Frisco <mildred.frisco@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: making a linux kernel with no root filesystem
Date: Thu, 21 Oct 2004 14:53:22 +0300
User-Agent: KMail/1.5.4
References: <e7b30b2404102102466dc71118@mail.gmail.com>
In-Reply-To: <e7b30b2404102102466dc71118@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410211453.22507.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 October 2004 12:46, Mildred Frisco wrote:
> Hi,
> I would like to ask help in compiling a minimal linux kernel. 
> Basically, it would only contain the kernel andno filesystem (or
> probably devfs).  I would only have to boot the kernel from floppy.
> Then after the necessary kernel initializations, I would issue a
> prompt where I can either shutdown or reboot the system. That's the
> only functionality required.  As I've learned from the init program
> (and startup scripts), the init services and shutdown commands are
> called from /sbin. However, I do not require to mount the root fs
> anymore.  I also tried to search for the source code of the shutdown
> program but I can't find it.  Please help on the steps that I should
> do.

Okay please imagine that kernel initialized all hardware and,
now, what shall it do instead of mounting root fs and starting
$INIT?

You want a "prompt where I can either shutdown or reboot the system".
How to do that? It is best done from small userspace environment,
like initrd or initramfs. Putting this into kernel is ugly.
--
vda

