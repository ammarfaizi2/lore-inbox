Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbTJNOxY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 10:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbTJNOxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 10:53:24 -0400
Received: from intra.cyclades.com ([64.186.161.6]:12000 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262667AbTJNOxW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 10:53:22 -0400
Date: Tue, 14 Oct 2003 11:53:57 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
Cc: Linux Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: __alloc_pages: 0-order allocation failed on 2.4.23-pre5 and pre7
In-Reply-To: <Pine.OSF.4.51.0310122353440.468559@tao.natur.cuni.cz>
Message-ID: <Pine.LNX.4.44.0310141152320.3275-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Oct 2003, [iso-8859-2] Martin MOKREJ© wrote:

> Hi,
>   it's a long time I haven't seen sthis messages, but it just happened that
> I did on my laptop ASUS L3880C(1GB RAM). The message show on
> 2.4.23-pre5+acpi20030918 and 2.4.23-pre7. The application get's killed on
> 2.4.22-acpi20030918 too, just without the "0-order allocation" message.
> I enabled in kernel the VM allocation debug option when configuring, but
> apparently I have to turn it on also somewhere else. *Documentation* is
> missing: 1) the help in "make config/menuconfig" etc. doesn't say anything,
> the Documentation subdirectory doesn't say anything except "debug" as
> kernel boot option on command-line(I did that too, but no change) and also
> linux kernel-FAQ doesn't say either. :(
> 
> How I tested?
> `gzip -dc file | less' and pressed `G' to jump to the very end of the file.
> The filesize is 280MB only. In a while, the mouse stopps moving for a
> while, than the system gets sometimes unloaded, fan is raises it's RPM's up
> and down town to time, and mouse cursor eventually does a move and then
> less command gets killed. In dmesg I found:
> 
> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> VM: killing process less

Did you try to add some swap to the system? 

It seems you have none.

