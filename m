Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262141AbUKDLMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbUKDLMY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 06:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbUKDLMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 06:12:24 -0500
Received: from sd291.sivit.org ([194.146.225.122]:5337 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262141AbUKDLMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 06:12:16 -0500
Date: Thu, 4 Nov 2004 12:12:31 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/12] meye driver update
Message-ID: <20041104111231.GF3472@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please find attached a collection of patches updating the meye driver
to the latest version.

The main changes in these patches are:
	- migrate to module_param();
	- implement the V4L2 API in addition to V4L1
	- many code, whitespace and coding style cleanups

Full changelog below, the patches will be send as followups to this one.

Please apply.

Thanks,

Stelian.

PATCH  1/12: meye: module related fixes
	* use module_param() instead of MODULE_PARM() and __setup()
	* use MODULE_VERSION()

PATCH  2/12: meye: replace homebrew queue with kfifo

PATCH  3/12: meye: picture depth is in bits not in bytes

PATCH  4/12: meye: do lock properly when waiting for buffers

PATCH  5/12: meye: implement non blocking access using poll()

PATCH  6/12: meye: cleanup init/exit paths

PATCH  7/12: meye: the driver is no longer experimental and depends on PCI

PATCH  8/12: meye: module parameters documentation fixes

PATCH  9/12: meye: add v4l2 support

PATCH 10/12: meye: whitespace and coding style cleanups

PATCH 11/12: meye: bump up the version number

PATCH 12/12: meye: retrieving the current settings from the camera does not work
		   very well, we need to cache the values in the driver

-- 
Stelian Pop <stelian@popies.net>    
