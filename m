Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbUAYJlR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 04:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbUAYJlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 04:41:17 -0500
Received: from [62.38.235.6] ([62.38.235.6]:60870 "EHLO pfn1.pefnos")
	by vger.kernel.org with ESMTP id S263861AbUAYJlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 04:41:17 -0500
From: "P. Christeas" <p_christ@hol.gr>
To: acpi-devel@lists.sourceforge.net, Vojtech Pavlik <vojtech@suse.cz>,
       lkml <linux-kernel@vger.kernel.org>
Subject: FYI: ACPI 'sleep 1' resets atkbd keycodes
Date: Sun, 25 Jan 2004 11:37:19 +0200
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401251137.21646.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This may be just a minor issue:
I had to use the setkeycodes utility to enable some extra keys (that weren't 
mapped by kernel's atkbd tables).
After waking from sleep 1, those keys were reset. That is, I had to use 
'setkeycodes' again to customize the tables again.

IMHO the way kernel works now is correct. It should *not* have extra code just 
to handle that. Just make sure anybody that alters his kbd tables puts some 
extra script to recover the tables after an ACPI wake.
This should be more like a note to Linux distributors.

Have a nice day.
