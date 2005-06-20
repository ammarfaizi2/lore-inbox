Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVFTUhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVFTUhL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 16:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVFTUhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 16:37:10 -0400
Received: from dvhart.com ([64.146.134.43]:19121 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261541AbVFTUgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 16:36:00 -0400
Date: Mon, 20 Jun 2005 13:35:56 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@muc.de>
Subject: 2.6.12-git1 broken on x86_64 (works on 2.6.12)
Message-ID: <563690000.1119299756@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fails to reboot, see:

http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/6035/debug/console.log

basically:

VFS: Cannot open root device "sda1" or unknown-block(0,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)

Looks like it didn't find the SCSI card at all ... MPT fusion, IIRC.
I'll poke at it a bit tommorow, but if you've got any good guesses as
to what broke it, let me know (hopefully something trivial like config
options).

M.

