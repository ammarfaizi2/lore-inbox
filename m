Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271120AbTHHAab (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 20:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271123AbTHHAab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 20:30:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:59099 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271120AbTHHAaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 20:30:30 -0400
Date: Thu, 7 Aug 2003 17:32:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: "H. J. Lu" <hjl@lucon.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initrd problem with 2.6 kernel
Message-Id: <20030807173230.13f57349.akpm@osdl.org>
In-Reply-To: <20030807223019.GA27359@lucon.org>
References: <20030807223019.GA27359@lucon.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. J. Lu" <hjl@lucon.org> wrote:
>
> There is a chicken and egg problem with initrd on 2.6. When
> root=/dev/xxx is passed to kernel, kernel will call try_name, which
> uses /sys/block/drive/dev, to find out the device number for ROOT_DEV.
> The problem is /sys/block/drive may not exist if the driver is loaded
> by /linuxrc in initrd. As the result, /linuxrc can't use
> /proc/sys/kernel/real-root-dev to determine the root device number.

You should be able to use the numeric identifier:

	root=03:02

that's major:minor, and it recently changed.  In 2.6.0-test2 that would be
"0302".


