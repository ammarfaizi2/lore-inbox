Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbTEQOFm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 10:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTEQOFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 10:05:42 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:26088 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S261500AbTEQOFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 10:05:41 -0400
Date: Sat, 17 May 2003 15:21:29 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Greg KH <greg@kroah.com>
Cc: Manuel Estrada Sainz <ranty@debian.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>
Subject: Re: request_firmware() hotplug interface, third round.
Message-ID: <20030517152129.F626@nightmaster.csn.tu-chemnitz.de>
References: <20030515200324.GB12949@ranty.ddts.net> <20030516223624.GA16759@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030516223624.GA16759@kroah.com>; from greg@kroah.com on Fri, May 16, 2003 at 03:36:24PM -0700
X-Spam-Score: -5.0 (-----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19H2W9-0002qk-00*M3791kQn2vs*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 16, 2003 at 03:36:24PM -0700, Greg KH wrote:
> Other than those very minor tweaks, I like this interface, it's looking
> very good.  I wouldn't worry about any "checksum" calcuation crud, it's
> up to the userspace tool dumping the firmware to the kernel to make sure

Ok, if that is true, then we could also have this tool enforce a
size. Otherwise we are reading and reading without ever ending
and allocating a lot of kernel resources while we are at it.

If we know the size, then we also now start and end. So the
"loading" attribute can certainly go.

Regards

Ingo Oeser
