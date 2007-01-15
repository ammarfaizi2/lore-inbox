Return-Path: <linux-kernel-owner+w=401wt.eu-S932359AbXAONxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbXAONxB (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 08:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbXAONxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 08:53:01 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:47564 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932343AbXAONxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 08:53:00 -0500
Message-ID: <45AB8738.6090405@garzik.org>
Date: Mon, 15 Jan 2007 08:52:56 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Alan <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Proposed changes for libata speed handling
References: <20070112135301.4cdba24f@localhost.localdomain>	<45A83DD2.5020000@gmail.com> <20070113100158.1d79ba9f@localhost.localdomain> <45AAF060.3040106@gmail.com>
In-Reply-To: <45AAF060.3040106@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, for a solution to be complete, we need to halt all work on all 
other ports, when issuing SET FEATURES - XFER MODE.  On SiI and Promise 
controllers, possibly others, the command is snooped and side effects 
such as register setting occur.

Long standing to-do.  Currently we hack around this by serializing the 
bus probe, and preventing people from issuing SET FEATURES - XFER MODE 
from userspace.

	Jeff



