Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262991AbTK3TF0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 14:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbTK3TF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 14:05:26 -0500
Received: from ppp-RAS1-2-51.dialup.eol.ca ([64.56.225.51]:3712 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S262991AbTK3TFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 14:05:20 -0500
Date: Sun, 30 Nov 2003 14:05:16 -0500
From: William Park <opengeometry@yahoo.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11 -- Failed to open /dev/ttyS0: No such device
Message-ID: <20031130190516.GA295@node1.opengeometry.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031130071757.GA9835@node1.opengeometry.net> <20031130102351.GB10380@outpost.ds9a.nl> <20031130113656.GA28437@finwe.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031130113656.GA28437@finwe.eu.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 12:36:56PM +0100, Jacek Kawa wrote:
> It reminds me, that I had to add serial to the list of modules
> loading at start to get back access to /dev/ttyS* 
> (while upgrading from -test9 to -test10). 
> 
> install serial /sbin/modprobe 8250 && { /etc/init.d/setserial modload  }

Yes, that did it.  'modprobe 8250' loads '8250' and 'serial_core'
modules.  It's odd that I have to be explicit about it in 2.6.0, whereas
2.4.23 loads 'serial' module automatically when dialing out.

-- 
William Park, Open Geometry Consulting, <opengeometry@yahoo.ca>
Linux solution for data management and processing. 
