Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267988AbUHNDjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267988AbUHNDjY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 23:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268005AbUHNDjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 23:39:24 -0400
Received: from rrcs-central-24-123-144-118.biz.rr.com ([24.123.144.118]:25456
	"EHLO zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id S267988AbUHNDjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 23:39:22 -0400
Subject: RE: High CPU usage (up to server hang) under heavy I/O load
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Sylvain COUTANT <sylvain.coutant@illicom.com>
Cc: "'Matt Domsch'" <Matt_Domsch@dell.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040813154737.7DCC12FC2C@illicom.com>
References: <20040813154737.7DCC12FC2C@illicom.com>
Content-Type: text/plain
Message-Id: <1092454748.3816.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 13 Aug 2004 23:39:09 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-13 at 11:46, Sylvain COUTANT wrote:
> Hello Matt,
> 
> > Which server please?
> 
> PE 2600 manufactured in June with latest PC BIOS and SCSI (PERC4/DI)
> BIOS/Firmware. We also tried downgrading to the previous release (as we have
> another PE2600 which runs fine with them) but it didn't do.

What driver are you using for the PERC?  We have a Dell 1750 with a
PERC/4Di which uses the megaraid driver under RHEL 3 and it has this
same problem, but only when writing to drives connected to PERC
controller.  The system also has a Qlogic 2312 card connected to a EMC
CX400 storage controller and performance to this device is fine, even if
I setup and LUN on a single ATA disk.

During heavy writes to the drives attached to the PERC4/Di the system
becomes practically unusable.  I've been wanting to try the 'megaraid2'
driver to see if this gets rid of the issue but I haven't been able to
try that yet.

We have some older systems with PERC2/DC cards which also use the
'megaraid' driver but they don't seem to experience this issue so I'm a
little suspicious that perhaps this driver simply doesn't work that well
with the newer megaraid-like controllers.

Later,
Tom


