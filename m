Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbTJGK6E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 06:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTJGK6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 06:58:03 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:4314 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S262094AbTJGK6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 06:58:01 -0400
Date: Tue, 7 Oct 2003 03:58:00 -0700 (PDT)
From: Tigran Aivazian <tigran@veritas.com>
To: linux-kernel@vger.kernel.org
Subject: RFC: changes to microcode update driver.
Message-ID: <Pine.GSO.4.44.0310070352590.16056-100000@south.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

It's been a long time that I was going to send to Linux the patch with the
following changes, but the birth of my first child intervened and caused
delays (though can't call them "unexpected" :). Now, if I hear from people
"no, no! we are using this feature!"  then I will reconsider:

1. Remove ->read() method for /dev/cpu/microcode device node and do not
hold a copy of applied microcode chunks in kernel memory. In the days when
we had a regular devfs file with a non-zero size this had at least some
potential use but now this feature is almost useless and removing it would
allow a lot of code cleanup and simplification.

2. remove MICROCODE_IOCFREE ioctl for freeing the copy of held microcode
(because there won't be such copy, see 1.)

Please let me know your thoughts.

Kind regards
Tigran

