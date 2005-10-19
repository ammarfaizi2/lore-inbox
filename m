Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbVJSKmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbVJSKmm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 06:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbVJSKmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 06:42:42 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:26179 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S964785AbVJSKml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 06:42:41 -0400
Date: Wed, 19 Oct 2005 12:42:40 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: number of eth0 device
Message-ID: <20051019104240.GC31526@harddisk-recovery.com>
References: <20051019103135.GA9765@kestrel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051019103135.GA9765@kestrel>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2005 at 12:31:35PM +0200, Karel Kulhavy wrote:
> I am looking into Documentation/devices.txt in 2.4.25 and eth0 is not listed
> there. If I grep "eth", I get only
> 
> 38 char        Myricom PCI Myrinet board
> [...]
> "This device is used for status query, board control and "user level
> packet I/O."  This board is also accessible as a standard networking
> "eth" device.  "
> 
> and then
> 
> /dev/pethr0
> 
> Is eth0 some kind of special device that doesn't have any number
> assigned?

Yes, there's no such thing as /dev/eth0, network interfaces have their
own namespace. Linux uses the defacto standard BSD socket interface for
networking, so blame the BSD people for violating the "everything is a
file" rule.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
