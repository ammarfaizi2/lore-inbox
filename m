Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWDSRJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWDSRJD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWDSRJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:09:01 -0400
Received: from emulex.emulex.com ([138.239.112.1]:62949 "EHLO
	emulex.emulex.com") by vger.kernel.org with ESMTP id S1750981AbWDSRJA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:09:00 -0400
Message-ID: <44466EA7.3030206@emulex.com>
Date: Wed, 19 Apr 2006 13:08:55 -0400
From: James Smart <James.Smart@Emulex.Com>
Reply-To: James.Smart@Emulex.Com
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Patrick McHardy <kaber@trash.net>
CC: linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Netlink and user-space buffer pointers
References: <1145306661.4151.0.camel@localhost.localdomain> <20060418160121.GA2707@us.ibm.com> <444633B5.5030208@emulex.com> <444663A9.9020502@trash.net>
In-Reply-To: <444663A9.9020502@trash.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Apr 2006 17:08:55.0847 (UTC) FILETIME=[F0F4EB70:01C663D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patrick McHardy wrote:
> This might be problematic, since there is a shared receive-queue in
> the kernel netlink message might get processed in the context of
> a different process. I didn't find any spots where ISCSI passes
> pointers over netlink, can you point me to it?

Please explain... Would the pid be set erroneously as well ?  Ignoring
the kernel-user space pointer issue, we're going to have a tight
pid + request_id relationship being maintained across multiple messages.
We'll also be depending on the pid events for clean up if an app dies.
So I hope pid is consistent.

-- james s
