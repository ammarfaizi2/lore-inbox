Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270933AbTGPKhq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 06:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270934AbTGPKhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 06:37:46 -0400
Received: from fed1mtao01.cox.net ([68.6.19.244]:22433 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S270933AbTGPKhp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 06:37:45 -0400
Date: Wed, 16 Jul 2003 03:52:36 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2 2.6.0-test1 issues
Message-ID: <20030716105236.GD25869@ip68-4-255-84.oc.oc.cox.net>
References: <20030716103851.GH2412@rdlg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716103851.GH2412@rdlg.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 06:38:51AM -0400, Robert L. Harris wrote:
> I can SSH out of my 2.6.0-test1 box (IPv4 and IPv6).  When I try to ssh
> in though I get a prompt for a passphrase like normal but once I enter
> it nothing happens it just hangs there.
> 
> On bootup I get multiple FATAL messages about tty and ttyS.  They're
> scattered throughout the startup process and don't seem tied to any
> particular init scripts.

Make sure you have a line in /etc/fstab for /dev/pts, like the
following:

none /dev/pts devpts defaults 0 0

My recollection is that I've seen this happen with at least some 2.4
kernels as well, so it's not a 2.6-specific thing. I may not be
remembering correctly, however.

Also note that some distributions will go ahead and mount /dev/pts
without having a line for it in /etc/fstab, so this isn't needed for all
Linux boxes.

-Barry K. Nathan <barryn@pobox.com>
