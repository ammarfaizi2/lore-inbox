Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbTI3VJy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 17:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbTI3VJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 17:09:53 -0400
Received: from ausadmmsps307.aus.amer.dell.com ([143.166.224.102]:34579 "HELO
	AUSADMMSPS307.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S261758AbTI3VJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 17:09:50 -0400
X-Server-Uuid: 82a6c0aa-b49f-4ad3-8d2c-07dae6b04e32
Message-ID: <36696BAFD8467644ABA0050BE35890590250175E@ausx2kmpc106.aus.amer.dell.com>
From: Gary_Lerhaupt@Dell.com
To: dkms-devel@lists.us.dell.com, linux-kernel@vger.kernel.org
Subject: DKMS enabled megaraid packages available
Date: Tue, 30 Sep 2003 16:09:31 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 13672E9C4461271-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For those interested in DKMS, we have put together two variants of megaraid
modules to demonstrate the convenient rebuilding features of DKMS (read:
method for distributing updated modules until a kernel release).

First, download the latest DKMS:
tarball: http://lerhaupt.com/dkms/permalink/dkms-0.39.17.tar.gz
rpm: http://lerhaupt.com/dkms/permalink/dkms-0.39.17-1.noarch.rpm

Next, download a DKMS enabled megaraid package:
megaraid (in tarball format):
http://domsch.com/linux/megaraid/dkms/megaraid_dkms-1.18k.tgz
megaraid2 (in RPM format):
http://domsch.com/linux/megaraid/dkms/megaraid2_dkms-2.00.9-2.noarch.rpm

To install a dkms enabled tarball (any source tarball which contains a
dkms.conf):
dkms ldtarball --archive=./megaraid_dkms-1.18k.tgz
dkms build -m megaraid -v 1.18k -k <kernel>
dkms install -m megaraid -v 1.18k -k <kernel>

To install a dkms enabled RPM:
rpm -ivh megaraid2_dkms-2.00.9-2.noarch.rpm
This will add the package source to your dkms tree, and then build and
install it for your currently running kernel.  You can then use dkms to
build and install it for any other kernel on your system.

Dell is looking seriously at using DKMS for customer updates, and we would
appreciate any feedback.  Note that most testing to date has occurred on Red
Hat.  Check http://lerhaupt.com/dkms/dkms.html for a list of changes.

Gary Lerhaupt
Dell Linux Development

