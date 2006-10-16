Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWJPIne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWJPIne (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 04:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWJPIne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 04:43:34 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:33815 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S964843AbWJPInd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 04:43:33 -0400
Date: Mon, 16 Oct 2006 10:44:07 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Patch 0/3] Driver core: Some probing changes
Message-ID: <20061016104407.0fc87c4c@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following patches attempt to fix some issues in the current device
probing code:

[1/3] Don't stop probing on ->probe errors.
[2/3] Change function call order in device_bind_driver().
[3/3] Per-subsystem multithreaded probing.

Patches are against -gkh tree. Works for me on s390 and on i386 with
pci multithreaded probing enabled. (I also enabled multithreaded
probing on the css and ccw busses in order to test the code on s390,
but this doesn't make much sense since we already do async device
recognition, so I'm not sending a patch.)
