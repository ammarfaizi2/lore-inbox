Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262649AbULPJyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbULPJyi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 04:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbULPJyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 04:54:38 -0500
Received: from canuck.infradead.org ([205.233.218.70]:49681 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262487AbULPJyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 04:54:31 -0500
Subject: Re: How to add/drop SCSI drives from within the driver?
From: Arjan van de Ven <arjan@infradead.org>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>, brking@us.ibm.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, bunk@fs.tum.de,
       Andrew Morton <akpm@osdl.org>, "Ju, Seokmann" <sju@lsil.com>,
       "Doelfel, Hardy" <hdoelfel@lsil.com>, "Mukker, Atul" <Atulm@lsil.com>
In-Reply-To: <20041215213001.GA9284@lists.us.dell.com>
References: <60807403EABEB443939A5A7AA8A7458B7F5071@otce2k01.adaptec.com>
	 <1102536081.4218.0.camel@localhost.localdomain>
	 <20041215072453.GB17274@lists.us.dell.com>
	 <1103136559.5232.1.camel@mulgrave>
	 <20041215213001.GA9284@lists.us.dell.com>
Content-Type: text/plain
Date: Thu, 16 Dec 2004 10:54:12 +0100
Message-Id: <1103190852.4136.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-15 at 15:30 -0600, Matt Domsch wrote:
> Do you plan to apply LSI's driver patch which adds the driver-private
> ioctl to provide the mapping from logical drive address to HCTL value?
> Both Dell and LSI have products which are lined up to use this new
> ioctl because it's the most expedient thing to do, maintains internal
> project schedules, etc, which delaying until this sysfs mechanism hits
> will greatly impact those schedules. (I know, many folks on this list
> don't care about business-side impacts of choices made on-list.)

I'm strongly against adding this. The reason for that is that once an
ioctl is added, it realistically will and can never go away.
LSI is free to have their own fork and give that to dell; but they
should and could have known that it wasn't going to fly. (same I guess
for adaptec ioctls). The companies who then commit to some schedule
realize they take a huge risk, but that is no reason to foul up the
kernel more. 

