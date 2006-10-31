Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422800AbWJaGjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422800AbWJaGjP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 01:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422804AbWJaGjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 01:39:15 -0500
Received: from smtp-out.google.com ([216.239.45.12]:37867 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1422800AbWJaGjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 01:39:15 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:mime-version:to:cc:
	subject:references:in-reply-to:content-type:content-transfer-encoding;
	b=qqRtz5zt16/0o//ZuxEukVxcrPKj8WKMQXdaLbGQq5C/3KkqJFFNZ15q1OcaHDI9V
	bdod30YtD9jfUNrkzYGpg==
Message-ID: <4546EF3B.1090503@google.com>
Date: Mon, 30 Oct 2006 22:37:47 -0800
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Cornelia Huck <cornelia.huck@de.ibm.com>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
References: <20061029160002.29bb2ea1.akpm@osdl.org>	 <45461977.3020201@shadowen.org> <45461E74.1040408@google.com>	 <20061030084722.ea834a08.akpm@osdl.org> <454631C1.5010003@google.com>	 <45463481.80601@shadowen.org>	 <20061030211432.6ed62405@gondolin.boeblingen.de.ibm.com> <1162276206.5959.9.camel@Homer.simpson.net>
In-Reply-To: <1162276206.5959.9.camel@Homer.simpson.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Mon, 2006-10-30 at 21:14 +0100, Cornelia Huck wrote:
> 
>> Maybe the initscripts have problems coping with the new layout
>> (symlinks instead of real devices)?
> 
> SuSE's /sbin/getcfg for one uses libsysfs, which apparently doesn't
> follow symlinks (bounces off symlink and does nutty stuff instead).  If
> any of the boxen you're having troubles with use libsysfs in their init
> stuff, that's likely the problem.

If that is what's happening, then the problem is breaking previously
working boxes by changing a userspace API. I don't know exactly which
patch broke it, but reverting all Greg's patches (except USB) from
-mm fixes the issue.

M.
