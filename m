Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266806AbUFYRR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266806AbUFYRR3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 13:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266807AbUFYRR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 13:17:29 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:21005 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266806AbUFYRR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 13:17:28 -0400
Message-ID: <40DC62BD.3010607@techsource.com>
Date: Fri, 25 Jun 2004 13:37:01 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: alan <alan@clueserver.org>, "Fao, Sean" <Sean.Fao@dynextechnologies.com>,
       linux-kernel@vger.kernel.org, Amit Gud <gud@eth.net>
Subject: Re: Elastic Quota File System (EQFS)
References: <20040624220318.GE20649@elf.ucw.cz> <Pine.LNX.4.44.0406241544010.19187-100000@www.fnordora.org> <20040625001545.GI20649@elf.ucw.cz>
In-Reply-To: <20040625001545.GI20649@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a much simpler idea that both implements the EQFS and doesn't 
touch the kernel.

Each user is given a quota which applies to their home directory.  (This 
quota is not elastic and if everyone met their quota, everything would 
fit.)  In addition, there is another directory or file system (could be 
on the same disk or even the same partition) to which their quota 
doesn't apply AT ALL.  Let's call this "scratch" space.

Periodically, a daemon checks the disk usage, and whenever the disk 
usage approaches, say, 90%, its starts deleting the oldest files from 
the scratch space until its gets below the watermark.

So anything in "/scratch/$USER/" is free to be deleted by the daemon.

BTW, they did something similar to this when I was in college (I 
graduated in 1996), although they deleted from /scratch manually.

