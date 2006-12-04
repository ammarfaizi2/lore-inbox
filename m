Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759217AbWLDD56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759217AbWLDD56 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 22:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759229AbWLDD56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 22:57:58 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:9640 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1759217AbWLDD55 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 22:57:57 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [Openipmi-developer] [PATCH 9/12] IPMI: add pigeonpoint poweroff
Date: Sun, 3 Dec 2006 19:53:48 -0800
Message-ID: <FE74AC4E0A23124DA52B99F17F44159701DBC05B@PA-EXCH03.vmware.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Openipmi-developer] [PATCH 9/12] IPMI: add pigeonpoint poweroff
Thread-Index: AccXT4dShjHaXeUoR2aPPgHcLx3mrwACEZCn
References: <20061202043746.GE30531@localdomain><20061203132618.d7d58f59.akpm@osdl.org> <45738959.1000209@acm.org> <20061203185442.33faf1c0.randy.dunlap@oracle.com>
From: "Bela Lubkin" <blubkin@vmware.com>
To: "Randy Dunlap" <randy.dunlap@oracle.com>, "Andrew Morton" <akpm@osdl.org>
Cc: "Corey Minyard" <minyard@acm.org>,
       "OpenIPMI Developers" <openipmi-developer@lists.sourceforge.net>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Joseph Barnett" <jbarnett@motorola.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> > Sometime, please go through the IPMI code looking for all these
> > statically-allocated things which are initialised to 0 or NULL and remove
> > all those intialisations?  They're unneeded, they increase the vmlinux
> > image size and there are quite a number of them.  Thanks.

Randy Dunlop replied:

> I was just about to send that patch.  Here it is,
> on top of the series-of-12.
...
> -static int bt_debug = BT_DEBUG_OFF;
> +static int bt_debug;

Is it wise to significantly degrade code readability to work around a minor
compiler / linker bug?

>Bela<
