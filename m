Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264301AbUE3U16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264301AbUE3U16 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 16:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264337AbUE3U16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 16:27:58 -0400
Received: from cantor.suse.de ([195.135.220.2]:39811 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264301AbUE3U15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 16:27:57 -0400
Date: Sun, 30 May 2004 22:25:08 +0200
From: Olaf Hering <olh@suse.de>
To: Joshua Kwan <joshk@triplehelix.org>, netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: consistent ioctl for getting all net interfaces?
Message-ID: <20040530202508.GA31468@suse.de>
References: <pan.2004.05.23.04.28.28.143054@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pan.2004.05.23.04.28.28.143054@triplehelix.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, May 22, Joshua Kwan wrote:

> Hi,
> 
> I'm interested in not having to parse /proc/net/dev to get a list of all
> available (not necessarily even up) interfaces on the system. I
> investigated the ioctl SIOCGIFCONF, but it seems to behave differently on
> 2.4 and 2.6 series kernels, e.g. sometimes it won't return all interfaces.

you should bring that to netdev@oss.sgi.com instead of lkml.

IF the ioctl has really changed, then it would be a bug. I just played
with ipconfig from the klibc distribution, and it returns only
interfaces in UP state. I'm sure that ipconfig binary worked when the
code was written.

If the ioctl is supposed to work how it does in 2.6, there is still
/sys/class/net/*. Thats (probably) more reliable than a text parser.
See `nameif -r 'foo: bar' eth0` as example.


-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
