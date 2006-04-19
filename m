Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWDSRQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWDSRQN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWDSRQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:16:13 -0400
Received: from stinky.trash.net ([213.144.137.162]:17078 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1751102AbWDSRQL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:16:11 -0400
Message-ID: <4446705A.2080101@trash.net>
Date: Wed, 19 Apr 2006 19:16:10 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James.Smart@Emulex.Com
CC: linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Netlink and user-space buffer pointers
References: <1145306661.4151.0.camel@localhost.localdomain> <20060418160121.GA2707@us.ibm.com> <444633B5.5030208@emulex.com> <444663A9.9020502@trash.net> <44466EA7.3030206@emulex.com>
In-Reply-To: <44466EA7.3030206@emulex.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Smart wrote:
> 
> 
> Patrick McHardy wrote:
> 
>> This might be problematic, since there is a shared receive-queue in
>> the kernel netlink message might get processed in the context of
>> a different process. I didn't find any spots where ISCSI passes
>> pointers over netlink, can you point me to it?
> 
> 
> Please explain... Would the pid be set erroneously as well ?  Ignoring
> the kernel-user space pointer issue, we're going to have a tight
> pid + request_id relationship being maintained across multiple messages.
> We'll also be depending on the pid events for clean up if an app dies.
> So I hope pid is consistent.

The PID contained in the netlink message itself is correct, current->pid
might not be.
