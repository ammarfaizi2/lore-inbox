Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263627AbUCUKbO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 05:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263629AbUCUKbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 05:31:14 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:64431 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S263627AbUCUKbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 05:31:11 -0500
Date: Sun, 21 Mar 2004 02:31:08 -0800
From: Frank Cusack <fcusack@fcusack.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Does Linux sync(2) wait?
Message-ID: <20040321023107.A31553@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at 2.4 and 2.6 sources, Linux does appear to wait before returning.
I'm especially interested if NFS data is sent to the server.  (I want to
be able to take a stable snapshot of a netapp volume.)

But on my RHL 9 system, I have 3 different man pages and an info page,
all of which say something different.

sync(2) says:

       According  to the standard specification (e.g., SVID), sync() schedules
       the writes, but may return before the actual writing is done.  However,
       since  version  1.3.20  Linux does actually wait. 

sync(8) says:

       On Linux, sync is only guaranteed to  schedule  the  dirty  blocks  for
       writing;  it  can  actually take a short time before all the blocks are
       finally written.  

sync(1) is in the middle and doesn't really say anything, it refers to
the info page which also isn't specific.

/fc
