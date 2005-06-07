Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbVFGWeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVFGWeb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 18:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbVFGWeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 18:34:31 -0400
Received: from fmr17.intel.com ([134.134.136.16]:41938 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S262018AbVFGWe2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 18:34:28 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: pci_enable_msi() for everyone?
Date: Tue, 7 Jun 2005 15:33:28 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502408D8D101@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: pci_enable_msi() for everyone?
Thread-Index: AcVrINnrQLBJ1J3XSimhJ4I+fwp6PAAj68+w
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Greg KH" <gregkh@suse.de>, "Roland Dreier" <roland@topspin.com>
Cc: "Dave Jones" <davej@redhat.com>,
       "Grant Grundler" <grundler@parisc-linux.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>, <linux-kernel@vger.kernel.org>,
       <davem@davemloft.net>, "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 07 Jun 2005 22:33:29.0994 (UTC) FILETIME=[EDEAEEA0:01C56BB0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Monday, June 06, 2005 10:22 PM Greg KH wrote:
>> 
>> Huh?  If a host bridge doesn't support MSI, and a device below it has
>> its MSI capability enabled, we're in big trouble.  Because that
device
>> is going to send interrupt messages whether the bridge likes it or
>> not.
>
>No, that device would never get MSI enabled on it.  See the patch I
>posted to make sure I didn't get it wrong...

You're correct. If a host bridge doesn't support MSI, MSI quirk is set
to indicate that do not enable MSI/MSI-X on any device.

Thanks,
Long
