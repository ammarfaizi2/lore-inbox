Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVC1Qsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVC1Qsy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 11:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbVC1Qsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 11:48:54 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:56781 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261941AbVC1Qsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 11:48:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=fmiW3luA1JHEijnRSoOJwFnnWkEP5oWyyF2GiN+rvdHy8PfpfuHEG922bl2bozM24tBXuSXgSZcRorPQ8ZrgGs5zVm1qttKykHWSZIbDF84ldgguUOOCBBy3MfUoNOt/omgxG7WHsDcfLEpRcpYMsKVQIIqaKFjvCPqBR6Zmjy0=
Message-ID: <aa4c40ff05032808487c83c839@mail.gmail.com>
Date: Mon, 28 Mar 2005 08:48:35 -0800
From: James Lamanna <jlamanna@gmail.com>
Reply-To: James Lamanna <jlamanna@gmail.com>
To: linux-usb-devel@lists.sourceforge.net
Subject: More FTDI 232BM chip issues...
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier I posted about having long delay issues when reading back
bytes from a FTDI 232BM USB->Serial chip.
Now, I've noticed that after a long period of time of semi-continual
use (maybe 8+ hours) I see the following messages in my kernel.log:

Mar 24 23:46:42 displaytest kernel: hub 2-0:1.0: port 2 disabled by
hub (EMI?), re-enabling...
Mar 24 23:46:42 displaytest kernel: usb 2-2: USB disconnect, address 4
Mar 24 23:46:42 displaytest kernel: ftdi_sio 2-2:1.0: device disconnected
Mar 24 23:46:42 displaytest kernel: usb 2-2: new full speed USB device
using address 5
Mar 24 23:46:42 displaytest kernel: ftdi_sio 2-2:1.0: FTDI FT232BM
Compatible converter detected
Mar 24 23:46:42 displaytest kernel: usb 2-2: FTDI FT232BM Compatible
converter now attached to ttyUSB1

Of course I have a test program running overnight and when the device
comes back up it switches device names (because my test program has
the port still open), which causes it to die at that point.

Is there any particular reason the hub would disable that port? Or am
I in flakey hardware land here?

Thanks.

-- James Lamanna
