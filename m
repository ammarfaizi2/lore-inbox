Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbTJ0HL0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 02:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbTJ0HLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 02:11:25 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:274 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261235AbTJ0HLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 02:11:24 -0500
Date: Mon, 27 Oct 2003 07:11:20 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Matthew Wilcox <willy@debian.org>, "Moore, Eric Dean" <emoore@lsil.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  2.4.23-pre8 driver udpate for MPT Fusion (2.05.10)
Message-ID: <20031027071120.A11028@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, Matthew Wilcox <willy@debian.org>,
	"Moore, Eric Dean" <emoore@lsil.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <0E3FA95632D6D047BA649F95DAB60E57035A9458@exa-atlanta.se.lsil.com> <20031025191828.GA17144@kroah.com> <20031025204405.GB5172@parcelfarce.linux.theplanet.co.uk> <20031025210550.GB23437@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031025210550.GB23437@kroah.com>; from greg@kroah.com on Sat, Oct 25, 2003 at 02:05:50PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 25, 2003 at 02:05:50PM -0700, Greg KH wrote:
> Yeah, but some drivers almost do (Adaptec comes to mind.)  It will work
> in a pci hotplug system, while other scsi drivers will not work at all.

No, it won't work.  calling scsi_register outside ->detect on 2.4 will
just get you a dead Scsi_Host.

