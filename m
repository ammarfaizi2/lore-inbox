Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271073AbTHGWa2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 18:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271080AbTHGWa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 18:30:27 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:43986 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S271073AbTHGWa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 18:30:27 -0400
Date: Thu, 7 Aug 2003 15:30:19 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Initrd problem with 2.6 kernel
Message-ID: <20030807223019.GA27359@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a chicken and egg problem with initrd on 2.6. When
root=/dev/xxx is passed to kernel, kernel will call try_name, which
uses /sys/block/drive/dev, to find out the device number for ROOT_DEV.
The problem is /sys/block/drive may not exist if the driver is loaded
by /linuxrc in initrd. As the result, /linuxrc can't use
/proc/sys/kernel/real-root-dev to determine the root device number.


H.J.
