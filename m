Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbUCaVHu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 16:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbUCaVHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 16:07:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45515 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262488AbUCaVHp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 16:07:45 -0500
Message-ID: <406B3313.3080607@pobox.com>
Date: Wed, 31 Mar 2004 16:07:31 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Justin Cormack <justin@street-vision.com>
CC: Kernel mailing list <linux-kernel@vger.kernel.org>,
       mort@wildopensource.com
Subject: Re: [PATCH] libata transport attributes
References: <1080752942.27347.43.camel@lotte.street-vision.com>
In-Reply-To: <1080752942.27347.43.camel@lotte.street-vision.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Cormack wrote:
> Here is a rough patch to add libata transport attributes, along the
> lines of fibre channel and parallel scsi. I wrote it as it seemed to be
> the cleanest way of extracting ata-specific information (currently drive
> model, serial number and firmware revision) from sysfs (in
> /sys/class/libata_transport/). There are a few issues, in particular:
> 
> 1. it wont compile modular, as libata depends on scsi_transport_libata
> and vice-versa at the moment. I am not sure how you are supposed to get
> around this (and there arent any significant number of drivers in tree
> using the transport modules yet).
> 
> 2. It would be nice if the device directory in sysfs had a symlink to
> the transport attributes directory, not just the other way round.
> 
> 3. I couldnt work out what scsi_transport_template.size was the size of,
> as I couldnt see where it was used anywhere...
> 
> patch against 2.6.5-rc3-libata1 but probably applies against most recent
> kernels.


Did you see the comments I posted WRT mort's patch?

Since libata is leaving SCSI in 2.7, I would rather not add superfluous 
stuff like this at all.

Further, you can already retrieve the information you export with _zero_ 
new code.

	Jeff



