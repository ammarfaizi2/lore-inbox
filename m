Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbULPU62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbULPU62 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 15:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbULPU61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 15:58:27 -0500
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:36514 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S262016AbULPU5o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 15:57:44 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.10-rc2 start_udev very slow
Date: Thu, 16 Dec 2004 20:57:25 +0000
User-Agent: KMail/1.7.1
Cc: Greg KH <greg@kroah.com>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org> <200411171932.47163.andrew@walrond.org> <20041216155643.GB27421@kroah.com>
In-Reply-To: <20041216155643.GB27421@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412162057.25244.andrew@walrond.org>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 Dec 2004 15:56, Greg KH wrote:
> On Wed, Nov 17, 2004 at 07:32:47PM +0000, Andrew Walrond wrote:
> > I noticed that when upgrading from 2.6.8.1 to rc2, start_udev now takes
> > 10-15s after printing
> >
> > "Creating initial udev device nodes:"
>
> udevstart should be used instead of start_udev.  It goes a lot faster
> and fixes odd startup dependancies that are needed.

I'm using 048 at the moment. Works great, but if I replace start_udev with 
udevstart in my init scripts as you suggest, it all goes horribly wrong...

udevstart is just a symlink to udev, but start_udev is a script which:
 - mounts ramfs
 - runs udevstart
 - makes some extra nodes not exported by sysfs (stdin/out/err)

So I guess I need to migrate this functionality to my init system before I can 
call udevstart directly.

Is that list of  'extra nodes not exported by sysfs likely to change?'

Andrew Walrond
