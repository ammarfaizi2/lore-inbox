Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbTKSWyT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 17:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264182AbTKSWyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 17:54:19 -0500
Received: from user-0c8gj75.cable.mindspring.com ([24.136.76.229]:24205 "EHLO
	BL4ST") by vger.kernel.org with ESMTP id S262745AbTKSWyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 17:54:18 -0500
Date: Wed, 19 Nov 2003 14:54:25 -0800
From: Eric Wong <eric@yhbt.net>
To: linux-kernel@vger.kernel.org
Subject: notes on 2.4 -> 2.6 upgrade with a Serial ATA root
Message-ID: <20031119225425.GF24852@BL4ST>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When using the 2.4.22-xfs kernel (Knoppix -> Debian installation), our
SATA root drive shows up as /dev/hdg, but under 2.6, it's now a SCSI
device, /dev/sda.  It took us a while to figure out what was wrong until
we finally got a serial line and were able to read the boot message
outputs.

This is the error message we got originally _before_ we appended
"root=/dev/sda3" to our command-line:

VFS: Cannot open root device "2203" or unknown-block(34,3)
Please append a correct "root=" boot option

I have a feeling this will take a lot of SATA users by surprise, so
hopefully it'll be documented from now on.

-- 
Eric Wong                                        eric@yhbt.net
Petta Technologies                         eric@petta-tech.com
