Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268698AbRGZVrh>; Thu, 26 Jul 2001 17:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268699AbRGZVr1>; Thu, 26 Jul 2001 17:47:27 -0400
Received: from h24-78-175-24.vn.shawcable.net ([24.78.175.24]:9864 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S268698AbRGZVrO>;
	Thu, 26 Jul 2001 17:47:14 -0400
Date: Thu, 26 Jul 2001 14:47:19 -0700
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: read() details
Message-ID: <20010726144719.A2098@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Just some things I've always wondered about...

Is it safe to assume that when a single read() call of x bytes a file
(the file being locked against other processes appending to it) returns
less than x bytes, the next read() will always return 0?  If so, is it
portable to make such an assumption?

...Or is it always better to make sure read() returns 0 before assuming
EOF, perhaps because the kernel may want to promote contiguous-page
read()s or for some other reason?

On a related note, would there be a win in altering the first read() size
(at the beginning of a read loop) to allow the kernel to serve the
subsequent read requests from contiguous pages?  (This is assuming that
an lseek() happened first which would misalign the further read()s with
page boundaries.)

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
