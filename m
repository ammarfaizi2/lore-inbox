Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264856AbUEMTvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264856AbUEMTvs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264518AbUEMTsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:48:32 -0400
Received: from fmr01.intel.com ([192.55.52.18]:11679 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S264674AbUEMTqr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:46:47 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] ICH6/6300ESB i2c support
Date: Thu, 13 May 2004 12:46:18 -0700
Message-ID: <26CEE2C804D7BE47BC4686CDE863D0F5B1C46A@orsmsx410.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ICH6/6300ESB i2c support
Thread-Index: AcQ4wLw/sMud7dbmR12ZHMDM3iQK4wAX9fHw
From: "Gaston, Jason D" <jason.d.gaston@intel.com>
To: "Jean Delvare" <khali@linux-fr.org>, <jdgaston@snoqualmie.dp.intel.com>
Cc: "LKML" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 May 2004 19:46:19.0032 (UTC) FILETIME=[F5E51980:01C43922]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

The reason I have the renumbering in pci_ids.h and the new device
support in i2c-i801 in the same patch, is that the new device support is
dependent on the devices being added to pci_ids.h.  However, if it is
the consensus that these be two separate patches, I can separate them.

As far as using the ICHx model name is concerned; I can not use the
model name "82801xx" until after the product has launched.  I have also
seen requests to use the ICHx name rather then the model number.  Again,
if it is the consensus, I can go back after the product launches and
change all of the #defines, for the device, to use the model number
rather than the "common" name.

I will look into providing the same patch for the 2.4 kernel.

Thank you very much for looking at my patch,

Jason Gaston



-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: Thursday, May 13, 2004 1:05 AM
To: jdgaston@snoqualmie.dp.intel.com
Cc: LKML
Subject: Re: [PATCH] ICH6/6300ESB i2c support


Hi Jason,

A few comments on your patch:

> This patch adds DID support for ICH6 and 6300ESB to i2c-i801.c(SMBus).
In
> order to add this support I needed to patch pci_ids.h with the SMBus
DID's.
> To keep things orginized I renumbered the ICH6 and ESB entries in
pci_ids.h. 
> I then patched the piix IDE and i810 audio drivers to reflect the
updated
> #define's.  I also removed an error from irq.c; there was a reference
to a
> 6300ESB DID that does not exist.  This patch is against the 2.6.6
kernel.

To me, there are two different things here and you should split your
patch accordingly for clarity.  The renumbering of the entries should go
in a first patch, then the new devices support in i2c-i801 in a second.

I would also suggest that you follow the common habit to name the Intel
82801 chips after their numerical name (82801AA. 82801BA, etc...) and
not their nickname (ICH, ICH2...) in both the entries and the comments. 
Not that it is absolulety better, but that's the way we did so far, so
why change now?

I would appreciate it if you could submit a similar patch for the 2.4
version of the i2c-i801 driver as held in the lm_sensors project.

Thanks.

Jean Delvare


--
Jean "Khali" Delvare
http://khali.linux-fr.org/

