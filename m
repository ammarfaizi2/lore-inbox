Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWBFSPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWBFSPu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 13:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWBFSPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 13:15:50 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:48520 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932237AbWBFSPt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 13:15:49 -0500
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] s390: dasd extended error reporting module.
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFEACB8C3E.85A0843D-ONC125710D.00631F1E-C125710D.006451D4@de.ibm.com>
From: Stefan Weinhuber <WEIN@de.ibm.com>
Date: Mon, 6 Feb 2006 19:15:45 +0100
X-MIMETrack: Serialize by Router on D12ML065/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 06/02/2006 19:15:46,
	Serialize complete at 06/02/2006 19:15:46
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Blunck <jblunck@suse.de> wrote on 06.02.2006 12:30:46:

> Why don't you use the sysfs for this purpose? This new character device
> interface seems very odd to me. Why don't you introduce new attributes 
to the
> dasd device for that purpose and make online pollable for failovers?

We need to transfer binary data records, and in case of an error
situation probably quite a number of them. Maybe sysfs could be bent to
that purpose but to me this seems even more awkward then a character 
device.

> Or use dm-netlink to report the extended errors via multipath to the 
user
> space.

Our interface is supposed to work under memory constrained situations
e.g. when the connection to the storage device failed. With our character
device we can constrain memory allocations to uncritical situations:
- when error reporting is enabled
- when the device is opened
- when the internal buffer size is adjusted
The error reporting itself is done without any additional allocations.

Best Regards /  Mit freundlichen Grüßen

Stefan Weinhuber

-------------------------------------------------------------------
IBM Deutschland Entwicklung GmbH
Linux for zSeries Development & Services
