Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273829AbRIREXy>; Tue, 18 Sep 2001 00:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273830AbRIREXo>; Tue, 18 Sep 2001 00:23:44 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:28990 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S273829AbRIREXh>;
	Tue, 18 Sep 2001 00:23:37 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Mark Atwood <mra@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to get version string and other metadata out of a not-loaded kernel module file? 
In-Reply-To: Your message of "17 Sep 2001 13:02:36 MST."
             <m3ofo9k2lf.fsf_-_@flash.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 18 Sep 2001 14:22:27 +1000
Message-ID: <8813.1000786947@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Sep 2001 13:02:36 -0700, 
Mark Atwood <mra@pobox.com> wrote:
>Is there an (easy) way to query the "metadata", such as the version
>strings and such, of a kernel module file, without loading it first?

With modutils >= 2.4.5.

# modinfo loop
filename:    /lib/modules/2.4.10-pre8-xfs/kernel/drivers/block/loop.o
description: <none>
author:      <none>
parm:        max_loop int, description "Maximum number of loop devices (1-255)"

# strings -a /lib/modules/2.4.10-pre8-xfs/kernel/drivers/block/loop.o | grep kernel_version=
kernel_version=2.4.10-pre8-xfs

