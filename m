Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271174AbTHLXyF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 19:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271235AbTHLXyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 19:54:05 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:49821 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S271174AbTHLXyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 19:54:01 -0400
Date: Wed, 13 Aug 2003 00:53:24 +0100
From: Dave Jones <davej@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Matthew Wilcox <willy@debian.org>, jgarzik@pobox.com, davem@redhat.com,
       linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-ID: <20030812235324.GA12953@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
	Matthew Wilcox <willy@debian.org>, jgarzik@pobox.com,
	davem@redhat.com, linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net
References: <20030812020226.GA4688@zip.com.au> <1060654733.684.267.camel@localhost> <20030812023936.GE3169@parcelfarce.linux.theplanet.co.uk> <20030812053826.GA1488@kroah.com> <20030812112729.GF3169@parcelfarce.linux.theplanet.co.uk> <20030812180158.GA1416@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030812180158.GA1416@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 11:01:58AM -0700, Greg KH wrote:

What would be *really* nice, would be the ability to do something
to the effect of..

	{
		.vendor		= PCI_VENDOR_ID_BROADCOM,
		.devices	= {
			PCI_DEVICE_ID_TIGON3_5700,
			PCI_DEVICE_ID_TIGON3_5701,
			PCI_DEVICE_ID_TIGON3_5702,
			PCI_DEVICE_ID_TIGON3_5703,
			PCI_DEVICE_ID_TIGON3_5704,
			PCI_DEVICE_ID_TIGON3_5702FE,
			PCI_DEVICE_ID_TIGON3_5702X,
			PCI_DEVICE_ID_TIGON3_5703X,
			PCI_DEVICE_ID_TIGON3_5704S,
			PCI_DEVICE_ID_TIGON3_5702A3,
			PCI_DEVICE_ID_TIGON3_5703A3,
		},
		.subvendor	= PCI_ANY_ID,
		.subdevice	= PCI_ANY_ID
	},
	{
		.vendor		= PCI_VENDOR_ID_SYSKONNECT,
		.device		= 0x4400,
		.subvendor	= PCI_ANY_ID,
		.subdevice	= PCI_ANY_ID
	},
	{
		.vendor		= PCI_VENDOR_ID_ALTIMA,
		.devices	= {
			PCI_DEVICE_ID_ALTIMA_AC1000,
			PCI_DEVICE_ID_ALTIMA_AC1001,
			PCI_DEVICE_ID_ALTIMA_AC9100,
		}
		.subvendor	= PCI_ANY_ID,
		.subdevice	= PCI_ANY_ID
	},
	{ 0, }
   };


-- 
 Dave Jones     http://www.codemonkey.org.uk
