Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVFFQYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVFFQYj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 12:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVFFQYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 12:24:39 -0400
Received: from mail.dvmed.net ([216.237.124.58]:2761 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261222AbVFFQYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 12:24:33 -0400
Message-ID: <42A478BE.1010907@pobox.com>
Date: Mon, 06 Jun 2005 12:24:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <liml@rtr.ca>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libata: shelved ioctl-get-identity patch
References: <42A12E80.8090203@pobox.com> <42A472AC.8040307@rtr.ca>
In-Reply-To: <42A472AC.8040307@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> For now, "hdparm -I" works just fine using HDIO_DRIVE_CMD,
> but if somebody could show me how to use ATA PASSTHRU,
> then I'll port it over to that.

Use the SG_IO ioctl to send ATA passthru CDBs.  Passthru CDBs are 
defined in the T10 "SAT" specification.

blktool should have example code ;-)

	Jeff


