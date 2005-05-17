Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbVEQW1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVEQW1T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 18:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVEQW1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 18:27:17 -0400
Received: from dvhart.com ([64.146.134.43]:19618 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261988AbVEQW0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 18:26:24 -0400
Date: Tue, 17 May 2005 15:26:14 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: dev@sw.ru, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI watchdog config option (was: Re: [PATCH] NMI lockup and AltSysRq-P dumping calltraces on _all_ cpus via NMI IPI)
Message-ID: <896520000.1116368774@flay>
In-Reply-To: <20050517151648.2abff61e.akpm@osdl.org>
References: <42822B5F.8040901@sw.ru><768860000.1116282855@flay><42899797.2090702@sw.ru><20050517001542.40e6c6b7.akpm@osdl.org><293160000.1116338500@[10.10.2.4]> <20050517151648.2abff61e.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > So much has changed in there that we might have fixed it by accident, and I
>> > do recall a couple of fundamental and subtle NMI bugs being fixed.  So
>> > yeah, it might be worth enabling it by default again.  Care to send a patch
>> > which does that?
>> 
>> There are some unfixable machine issues - for instance, the IBM
>> Netfinity 8500R corrupts one of the registers (ebx?) every time we get
>> an NMI for us, and panics. Probably other boxes you mention above have
>> similar issues? But it's not our code that's at fault ...
> 
> That sounds like an instant crash.  The problems which were reported a few
> years back were different - mysterious lockups after hours or days of
> operation.

Dunno, might have been a race, or only happened if the wind was blowing
North at the time. More likely different machines had different forms of
failures caused by various obscure bugs ;-) If you're really curious, I 
could go test it I spose.
 
>> In light of this, I don't think it's a good idea to enable NMI by default,
>> at least not without a blacklist function of some sort?
> 
> OK, thanks - I'll leave things as they stand.

Thanks. I think it's safer that way ...

M.

