Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265418AbTFXAXv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 20:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265450AbTFXAXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 20:23:51 -0400
Received: from firewall.ocs.com.au ([203.34.97.9]:22407 "EHLO
	firewall.ocs.com.au") by vger.kernel.org with ESMTP id S265418AbTFXAXu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 20:23:50 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 doesn't boot: /bin/insmod.old: file not found 
In-reply-to: Your message of "23 Jun 2003 20:40:17 +0200."
             <1056366638.2185.23.camel@shrek.bitfreak.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 24 Jun 2003 10:37:43 +1000
Message-ID: <23770.1056415063@firewall.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jun 2003 20:40:17 +0200, 
Ronald Bultje <rbultje@ronald.bitfreak.net> wrote:
>On Mon, 2003-06-23 at 11:26, Keith Owens wrote:
>> Did you copy /bin/insmod.old to the initrd that you are booting from?
>> Is /bin/insmod.old a static binary?
>
>/bin/insmod.old is a symlink to the dynamically linked binary in
>/sbin/insmod.old. The static one is in /{s,}bin/insmod.static.old.
>Should I swap them around?

initrd needs the static version of insmod.  Copy /sbin/insmod.static.old
to the ramdisk and rename it as /bin/insmod.old to suit the 2.5 modutils.

