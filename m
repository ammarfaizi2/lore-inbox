Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbVAPMEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbVAPMEm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 07:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbVAPMEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 07:04:41 -0500
Received: from verein.lst.de ([213.95.11.210]:56029 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262488AbVAPMEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 07:04:38 -0500
Date: Sun, 16 Jan 2005 13:04:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Thomas Viehmann <tv@beamnet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: permissions of /proc/tty/driver
Message-ID: <20050116120436.GA13906@lst.de>
References: <41E80535.1060309@beamnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E80535.1060309@beamnet.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 06:45:25PM +0100, Thomas Viehmann wrote:
> Hi.
> 
> This may not be stritly on topic, but I couln't figure out a better 
> place to ask:
> 
> During the packaging of an application, I have the following problem:
> I would like to run a daemon as non-root. The daemon likes to 
> (continually) check /proc/tty/driver/usbserial to see whether or not 
> interesting USB devices  are connected. The permissions of this actual 
> file is (on a kernel compiled from Debian's kernel-source-2.6.10) 0444, 
> so this isn't a problem. However, the parent directory /proc/tty/driver 
> is 0500. I'm not sure whether this is related to Debian DSAs 358 or 423 
> (where /proc/tty/driver/serial is mentioned as leaking sensitive 
> information), to me the contents of usbserial look innocent enough.
> Do you have any hints on what might be a good solution?

The permissions on the directory look indeed too strict to me.  It might
be better to just use strict permissions on /proc/tty/driver/serial
indeed.

Counter-question:  What information is available in
/proc/tty/driver/usbserial but not in sysfs?
