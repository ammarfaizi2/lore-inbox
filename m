Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262303AbUKDRme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbUKDRme (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 12:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbUKDRmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 12:42:33 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:32023 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262312AbUKDRk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 12:40:27 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Germano <germano.barreiro@cyclades.com>, greg@kroah.com,
       Scott_Kilau@digi.com, linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <1099487348.1428.16.camel@tsthost>
	<20041104102505.GA8379@logos.cnet> <52fz3po8k2.fsf@topspin.com>
	<20041104142925.GB9431@logos.cnet>
From: Roland Dreier <roland@topspin.com>
Date: Thu, 04 Nov 2004 09:40:21 -0800
In-Reply-To: <20041104142925.GB9431@logos.cnet> (Marcelo Tosatti's message
 of "Thu, 4 Nov 2004 12:29:25 -0200")
Message-ID: <523bzpo6m2.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: patch for sysfs in the cyclades driver
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 04 Nov 2004 17:40:25.0339 (UTC) FILETIME=[5DD544B0:01C4C295]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Marcelo> ------ Greg answer was:

    Greg> For a driver only attribute, you want them to show up in the
    Greg> place for the driver (like under
    Greg> /sys/bus/pci/driver/MY_FOO_DRIVER/).  To do that use the
    Greg> DRIVER_ATTR() and the driver_add_file() functions.  For
    Greg> examples, see the other drivers that use these functions.

I think Greg may have misunderstood the question and told you how to
expose per-driver attributes.  But I think the attributes you want
really are per-device and should be attached to the class_device, not
the driver.

 - Roland
