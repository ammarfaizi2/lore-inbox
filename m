Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968691AbWLEUkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968691AbWLEUkz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 15:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968694AbWLEUky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 15:40:54 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:55835 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S968691AbWLEUkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 15:40:53 -0500
Message-ID: <4575D951.3010705@sgi.com>
Date: Tue, 05 Dec 2006 14:40:49 -0600
From: Michael Reed <mdr@sgi.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20060911)
MIME-Version: 1.0
To: ltuikov@yahoo.com
CC: Andrew Morton <akpm@osdl.org>, linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Infinite retries reading the partition table
References: <520003.85125.qm@web31807.mail.mud.yahoo.com>
In-Reply-To: <520003.85125.qm@web31807.mail.mud.yahoo.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Luben Tuikov wrote:
...snip...
> This statement in scsi_io_completion() causes the infinite retry loop:
>    if (scsi_end_request(cmd, 1, good_bytes, !!result) == NULL)
>          return;

The code in 2.6.19 is "result==0", not "!!result", which is logically
the same as "result!=0".  Did you mean to change the logic here?
Am I missing something?

Mike
