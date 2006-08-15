Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965082AbWHOAEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbWHOAEo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 20:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965080AbWHOAEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 20:04:44 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:47623 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965078AbWHOAEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 20:04:43 -0400
Date: Tue, 15 Aug 2006 02:04:42 +0200
From: Adrian Bunk <bunk@stusta.de>
To: o.bock@fh-wolfenbuettel.de, gregkh@suse.de
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: drivers/usb/misc/cypress_cy7c63.c: NULL dereference
Message-ID: <20060815000442.GB3543@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity Checker spotted the following obvious NULL dereference:

<--  snip  -->

...
static int cypress_probe(struct usb_interface *interface,
                         const struct usb_device_id *id)
{
...
        if (dev == NULL) {
                dev_err(&dev->udev->dev, "Out of memory!\n");
                goto error;
        }
...
}
...

<--  snip  -->

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

