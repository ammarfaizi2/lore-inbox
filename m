Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbTDLXt0 (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 19:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbTDLXtZ (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 19:49:25 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:55816
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S262545AbTDLXtZ 
	(for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 19:49:25 -0400
Subject: Re: USB Mass Storage Device
From: Robert Love <rml@tech9.net>
To: dougg@torque.net
Cc: linux-kernel@vger.kernel.org, jim_jim33@hotmail.com
In-Reply-To: <3E98A050.2090005@torque.net>
References: <3E98A050.2090005@torque.net>
Content-Type: text/plain
Organization: 
Message-Id: <1050192040.2291.506.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 12 Apr 2003 20:00:40 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-04-12 at 19:25, Douglas Gilbert wrote:

> Have a look in /var/log/messages for errors coming from the
> sd driver (e.g. it could be stuck on a READ CAPACITY or MODE
> SENSE command). Other than that it could be a problem with
> devfs. You could make a temporary device node (e.g.
> 'cd /root; mknod my_sda b 8 0') then try fdisk on my_sda.

I see the same problem here without devfs.

The device does not even register itself as a block device.  I.e., on
boot it is detected and listed as sda but no sda* device is a valid
block device.  /sys/block/ does not list it.

Also no errors in dmesg...

	Robert Love

