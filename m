Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280785AbRKBSog>; Fri, 2 Nov 2001 13:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280783AbRKBSoc>; Fri, 2 Nov 2001 13:44:32 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:62342 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S280778AbRKBSoC>; Fri, 2 Nov 2001 13:44:02 -0500
Date: Fri, 2 Nov 2001 10:42:11 -0800
From: Russ Weight <rweight@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: bdevname(), cdevname(), kdevname() - static buffers
Message-ID: <20011102104211.A1279@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was looking at the usage of bdevname(), cdevname(), and kdevname(),
and noticed that they each return a pointer to a static buffer.
This buffer contains a formatted device name, which is typically
printed immediately following the call. However, I don't see any
explicit lock protection for these buffers.

For SMP systems, is there something implicit in their use that
prevents a race on these buffers? Has anyone seen garbled device
names being printed (which might be attributed to a race)?

- Russ

     ----------------------------------------------------------------------

Russ Weight  (rweight@us.ibm.com)
IBM Technology Center
