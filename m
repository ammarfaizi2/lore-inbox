Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262365AbUKDTP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbUKDTP2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 14:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbUKDTId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:08:33 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:52257 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262364AbUKDTFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:05:42 -0500
To: Greg KH <greg@kroah.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Germano <germano.barreiro@cyclades.com>, Scott_Kilau@digi.com,
       linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <1099487348.1428.16.camel@tsthost>
	<20041104102505.GA8379@logos.cnet> <52fz3po8k2.fsf@topspin.com>
	<20041104174044.GC16389@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Thu, 04 Nov 2004 11:05:40 -0800
In-Reply-To: <20041104174044.GC16389@kroah.com> (Greg KH's message of "Thu,
 4 Nov 2004 09:40:44 -0800")
Message-ID: <52bredmo3f.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: patch for sysfs in the cyclades driver
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 04 Nov 2004 19:05:41.0386 (UTC) FILETIME=[473C16A0:01C4C2A1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Roland> I assume this is OK (since there is already one in-kernel
    Roland> driver doing it), but Greg, can you confirm that it's
    Roland> definitely OK for a driver to use class_set_devdata() on a
    Roland> class_device from class_simple_device_add()?

    Greg> Hm, I think that should be ok, but I'd make sure to test it
    Greg> before verifying that it really is :)

Well class_simple.c definitely doesn't use class_data/class_set_devdata()
now (and as I said drivers/scsi/st.c is using this on a class_simple
device).  The question is whether you can bless this situation as part
of the API, or whether some time in the future class_simple might
start using class_data.

 - R.
