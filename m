Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262278AbVD1WDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbVD1WDK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 18:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbVD1WDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 18:03:09 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:46941 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262278AbVD1WCq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 18:02:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BvclXlBQpQ/9hpifbnVaZdtRZzSdLwXrGhMrtBObnJwW7NuCCbpkzFztltpAkYriwbbRmgpPq9h6Y28OLm9F9Mx94EK2JxlAq0TWs26zmxCl4TzRPtFflE0K4pu4ss+2SZsuQWLNQ+HhVce7Aj7ID+pN1DnGdlXyscnp/9CZ3fg=
Message-ID: <a728f9f905042815021a39e811@mail.gmail.com>
Date: Thu, 28 Apr 2005 18:02:43 -0400
From: Alex Deucher <alexdeucher@gmail.com>
Reply-To: Alex Deucher <alexdeucher@gmail.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Emulex fibre channel HBA support and SAN connection
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone point me to some documentation on setting up a fibre
channel HBA in linux?  I can't seem to find any useful information.  I
have a Sun 220R running 2.6.12-rc3 with an emulex LP9000 HBA connected
to a Nexsan ATABEAST SAN.  I'm using the HBA driver included with the
2.6.12rc3 kernel.  I cannot find any information about the GPLed
emulex driver as far as configuration goes.  The driver seems to come
up ok, but then I get a series of error codes:

Emulex LightPulse Fibre Channel SCSI driver 8.0.28
scsi0 :  on PCI bus 00 device 20 irq 8255744
lpfc 0001:00:04.0: 0:1303 Link Up Event x1 received Data: x1 x1 x8 x2
lpfc 0001:00:04.0: 0:0321 Unknown IOCB command Data: x0, xa2 x0 x900 x2600
...
lpfc 0001:00:04.0: 0:0748 abort handler timed out waiting for abort to
complete. Data: x0 x0 x0 x1
lpfc 0001:00:04.0: 0:0327 Rsp ring 0 error -  command completion for
iotag xa00 not found
lpfc 0001:00:04.0: 0:0327 Rsp ring 0 error -  command completion for
iotag x0 not found
lpfc 0001:00:04.0: 0:0713 SCSI layer issued LUN reset (0, 0) Data: x2 x0 x0
lpfc 0001:00:04.0: 0:0327 Rsp ring 0 error -  command completion for
iotag xb00 not found
lpfc 0001:00:04.0: 0:0327 Rsp ring 0 error -  command completion for
iotag x0 not found
lpfc 0001:00:04.0: 0:0714 SCSI layer issued Bus Reset Data: x2003
scsi: Device offlined - not ready after error recovery: host 0 channel
0 id 0 lun 0
lpfc 0001:00:04.0: 0:0327 Rsp ring 0 error -  command completion for
iotag x0 not found

I noticed here:
http://marc.theaimsgroup.com/?l=linux-scsi&m=111383889908554&w=2
that there is a new FC API. Was this merged into rc3 or will this
happen after 2.6.12?  If it's not supported yet in rc3, how does one
go about configuring it?  I'm willing to test any available tools.

Any help will be greatly appreciated.  I'll be able to test on SPARC64
right now and on AMD64 in the next few days.

Thanks,

Alex

PS, please CC: me as I'm not subscribed.
