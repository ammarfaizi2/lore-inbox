Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289148AbSBDRup>; Mon, 4 Feb 2002 12:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289166AbSBDRug>; Mon, 4 Feb 2002 12:50:36 -0500
Received: from dsl-65-186-161-49.telocity.com ([65.186.161.49]:13832 "EHLO
	nic.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S289148AbSBDRuZ>; Mon, 4 Feb 2002 12:50:25 -0500
Message-Id: <4.3.2.7.2.20020204124812.00aec590@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 04 Feb 2002 12:50:30 -0500
To: lkml <linux-kernel@vger.kernel.org>
From: David Relson <relson@osagesoftware.com>
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <20020204173137.6209E23CCB@persephone.dmz.logatique.fr>
In-Reply-To: <3C5EB070.4370181B@uni-mb.si>
 <3C5EB070.4370181B@uni-mb.si>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:34 PM 2/4/02, you wrote:


>A really useful patch makes all the options appeared in /proc/config.gz. It's
>used by SuSE kernels among others (mine, too :)
>You can find the patch on kernelnewbies.org (don't remember where exactly)
>
>
>zgrep CONFIG_PROC /proc/config.gz
>         will give you the answer.
>
>I have absolutely no clue why such a useful things is not integrated into the
>kernel yet. It's even useful for such things as "build a kernel using the
>same options as I have on current kernel but I don't know where my .config
>is".
>
>FWICS It seems harmful to me.
>
>
>Thomas


I remember discussion of that patch some time ago and the main complaint 
about it was that it increases the size of the kernel, i.e. vmlinuz.  Why 
not put the need info in a module?  Doing that would enable the following 
command:

         zgrep CONFIG_PROC /lib/modules/`uname -r`/config.gz

(or something similar).

David



