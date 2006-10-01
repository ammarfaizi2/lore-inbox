Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWJAMsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWJAMsn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 08:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWJAMsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 08:48:43 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:59127 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932135AbWJAMsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 08:48:42 -0400
To: balagi@justmail.de
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Greg KH" <greg@kroah.com>, torvalds@osdl.org, alan@redhat.com
Subject: Re: [PATCH 2.6.18] pktcdvd driver module: added sysfs interface
References: <op.tgd9kamfiudtyh@master> <op.tgqhg1pgiudtyh@master>
From: Peter Osterlund <petero2@telia.com>
Date: 01 Oct 2006 14:47:58 +0200
In-Reply-To: <op.tgqhg1pgiudtyh@master>
Message-ID: <m3d59ci4n5.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Thomas Maier" <balagi@justmail.de> writes:

> this is a patch for the packet writing module pktcdvd.
> The patch adds a sysfs and a debugfs interface, a Kconfig
> parameter to switch of the procfs interface off and a
> bio write queue congestion handling for the driver.

I think most of these changes are good. However, some comments:

* There are many logically independent parts in this change, so they
  should be in separate patches. For example:
  - Introduce the DRIVER_NAME #define.
  - Add sysfs support.
  - Make procfs support optional.
  - Implement congestion control.
  - Move lots of functions around. (Is it needed at all?)

* You need to add Signed-off-by.

* You should CC Andrew Morton and not Linus. These changes should live
  in -mm for a while before going into the main tree.

* The patch is white space damaged. All lines that should start with a
  single space start with two spaces.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
