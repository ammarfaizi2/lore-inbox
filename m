Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264422AbUEYBnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264422AbUEYBnE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 21:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264429AbUEYBnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 21:43:04 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:3493 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264422AbUEYBnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 21:43:01 -0400
Subject: Re: [announce/OT] kerneltop ver. 0.7
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: cef-lkml@optusnet.com.au, rddunlap@osdl.org, wli@holomorphy.com
Content-Type: text/plain
Organization: 
Message-Id: <1085440827.955.983.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 May 2004 19:20:27 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cef writes:

> Might want to add support for /boot/System.map containing
> the version number (eg: /boot/System.map-`uname -r` ),
> if /boot/System.map doesn't exist, before  just dropping
> out with an error.

Please search for this data in a procps-like order:

$PS_SYSMAP
$PS_SYSTEM_MAP
** see note **
/boot/System.map-`uname -r`
/boot/System.map
/lib/modules/`uname -r`/System.map
/usr/src/linux/System.map
/System.map

Where I mark "see note" would be a good place to
try /proc/kallsyms or similar. Also, you should
give up if the user gave a bad environment variable
rather than using some undesired data source.


