Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266221AbUI0Hwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUI0Hwa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 03:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266223AbUI0Hwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 03:52:30 -0400
Received: from mail1.kontent.de ([81.88.34.36]:31165 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S266221AbUI0Hw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 03:52:29 -0400
From: Oliver Neukum <oliver@neukum.org>
To: "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: suspend/resume support for driver requires an external firmware
Date: Mon, 27 Sep 2004 09:51:00 +0200
User-Agent: KMail/1.6.2
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Patrick Mochel" <mochel@digitalimplant.org>,
       "Zhu, Yi" <yi.zhu@intel.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <16A54BF5D6E14E4D916CE26C9AD305753457F2@pdsmsx402.ccr.corp.intel.com>
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD305753457F2@pdsmsx402.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409270951.00367.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 27. September 2004 08:23 schrieb Li, Shaohua:
> Adding methods to the device core requires changes the device core every
> time when you add a new call back. The notifier chain method can keep
> the device core stable.

No. It pretends that the interface is stable. If additional callbacks
are needed and provided externally, driver core is unable to do
what it is intended to.

> Considering another case, we might want to add some call backs between
> sysdevs resume and regular devices resume (the case is the above). It
> might not be for a device. How can the device core call back do this? 

The same way it resumes system devices.

	Regards
		Oliver
