Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264292AbTLaLF6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 06:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbTLaLF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 06:05:58 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:48103 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S264292AbTLaLF5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 06:05:57 -0500
Date: Wed, 31 Dec 2003 06:02:09 -0500
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-mm2] e100 driver hangs after period of moderate receive load
Message-ID: <20031231110209.GA9858@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Lennert Buytenhek <buytenh@gnu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After banging on an e100 card for about ten minutes with a ~60kpps stream,
the interface stops receiving packets.  Interrupts come in once every few
seconds (from /proc/interrupts), but no packets are received anymore at all.
Lots of slab corruption messages in the syslog that were generated during
that packet stream (see other email I sent.)  Stopping the packet stream
still leaves the interface unusable.  'ifconfig eth1 down ; ifconfig eth1 up'
seems to fix things.

Clues?


thanks,
Lennert
