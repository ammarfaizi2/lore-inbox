Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbTJFPiT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 11:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbTJFPiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 11:38:19 -0400
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:48603 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S262298AbTJFPiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 11:38:18 -0400
Subject: Re: [PATCH] s390 (2/7): common i/o layer.
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OFD63B1783.24148268-ONC1256DB7.005358E7-C1256DB7.0055CAB5@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Mon, 6 Oct 2003 17:37:04 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 06/10/2003 17:37:38
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You can still have a reference to the object when the module is unloaded.
>
> unregistered != last reference is gone

Hmpf, I think I see the problem now. We'd need to wait in the module
exit function until the release function for the root device has been
called. Can't say I like it but it's probably the easiest way out.

blue skies,
   Martin


