Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbTKZLVh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 06:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264144AbTKZLVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 06:21:37 -0500
Received: from vicar.dcs.qmul.ac.uk ([138.37.88.163]:52672 "EHLO
	mail.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP id S262161AbTKZLVg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 06:21:36 -0500
Date: Wed, 26 Nov 2003 11:21:33 +0000 (GMT)
From: Matt Bernstein <mb/lkml@dcs.qmul.ac.uk>
To: Chris Wright <chrisw@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6: can't lockf() over NFS
In-Reply-To: <20031125165501.A20302@build.pdx.osdl.net>
Message-ID: <Pine.LNX.4.58.0311261120220.22074@localhost.localdomain>
References: <Pine.LNX.4.58.0311251613230.20810@lucy.dcs.qmul.ac.uk>
 <20031125165501.A20302@build.pdx.osdl.net>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Bach-Choir-Authenticated-Sender: Matt Bernstein (mb, mid 4)
X-Auth-User: jonquil.thebachchoir.org.uk
X-DCS-Spam-Score: -1.0
X-clamav-result: clean (1AOxji-0003Cv-PN)
X-uvscan-result: clean (1AOxji-0003Cv-PN)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 25 Chris Wright wrote:

>> I tried writing a trivial program to test lockf() and it returns ENOLCK 
>> over NFS, but succeeds locally. The client kernel offers some grumbles:
>> 
>> RPC: Can't bind to reserved port (13).
>> RPC: can't bind to reserved port.
>> nsm_mon_unmon: rpc failed, status=-5
>> lockd: cannot monitor a.b.c.d
>> lockd: failed to monitor a.b.c.d

>Yes, can you either change your config to:
>
>CONFIG_SECURITY=n
>
>or:
>
>CONFIG_SECURITY=y
>CONFIG_SECURITY_CAPABILITIES=y
>
>or:
>
>CONFIG_SECURITY=y
>CONFIG_SECURITY_CAPABILITIES=m
>and modprobe capability
>
>Thanks, this had fallen off my radar.

Thank you, problem solved :)
