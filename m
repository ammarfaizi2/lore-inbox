Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266294AbUBLGBA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 01:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266295AbUBLGA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 01:00:59 -0500
Received: from terminus.zytor.com ([63.209.29.3]:24295 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S266294AbUBLGA6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 01:00:58 -0500
Message-ID: <402B168E.4020000@zytor.com>
Date: Wed, 11 Feb 2004 22:00:46 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: tytso@thunk.org, William Lee Irwin III <wli@holomorphy.com>
Subject: Updated dynamic pty patch available
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/dynpty-test-2.patch

... against the current top-of-bkcvs 2.6 kernel.

This version of the patch makes *both* legacy and Unix98 ptys configure 
options (Unix98 only if EMBEDDED), and the number of legacy ptys is a 
configuration option -- useful if you want to reduce the memory 
footprint, or if you really wants lots of these guys (256 is no longer a 
hard limit.)

Additionally, I have added a sysctl option -- /proc/sys/kernel/pty/max 
-- for limiting the number of Unix98 ptys.  It was way too effective a 
DoS to eat up all kernel memory by opening /dev/ptmx repeatedly.  The 
default is 4096, but it can be adjusted all the way up to 2^20 if desirable.

	-hpa


