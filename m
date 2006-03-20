Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030559AbWCTWFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030559AbWCTWFN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030558AbWCTWFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:05:09 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:33741 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030554AbWCTWEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:04:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=o55yTS+/EqZ9ceEBnmMXuDbihL7S3wOxTXyRR+uvIPnq2E3Ao+Lqooe3hevU/scMlJHJlcEyxD0OMMuQDqMpO7C+2kqjjig/qCw32GZVBREmmW4lWwo3H35gy2tMF9oNxA1ktMms6Q0DxJdhiAXta6TzCKtPgnk1PcitzH6YQDg=
Message-ID: <441F2727.6020407@gmail.com>
Date: Tue, 21 Mar 2006 00:05:27 +0200
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Mail/News 1.5 (X11/20060319)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Peter Wainwright <prw@ceiriog.eclipse.co.uk>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Announcing crypto suspend
References: <20060320080439.GA4653@elf.ucw.cz> <200603202126.23861.rjw@sisk.pl> <20060320203507.GF24523@elf.ucw.cz> <200603202222.14634.rjw@sisk.pl> <20060320213400.GI24523@elf.ucw.cz>
In-Reply-To: <20060320213400.GI24523@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
 > Of course, agreed. Encrypting filesystem is stupid thing from
> data-recovery standpoint; and I care about my data; it is also hard to
> backup. For some uses it is of course neccessary, but it has lots of
> disadvantages, too.

Pavel, you keep doing the same basic mistake...
Understand your client!

Suspend is a feature that is most used by the mobile community.
Disk encryption is also common for most of this community.
Putting them to work together should be your interest...
Calling your clients stupid is not wise!

> Encrypted swsusp has basically no disadvantages.
> 
> [I believe we should encrypt swap with random key generated on boot by
> default. That should be also very cheap, and has no real
> disadvantages].

Well... Good thinking... But how do you plan to encrypt the
swap? There are about 1000 ways to do this...

Jari Ruusu had written the loop-aes which was not merged...
>From a similar reason suspend2 was rejected by you.

I hope you don't think that file-system encryption should be
implemented in user mode too...

The dm-crypt is weak... So we left with specific encryption
implementation of swsusp... And now you offer a specific
encryption for swap as well... Why not realize that there
should be one encryption solution for block devices in kernel?

As a result of this mess the mobile community uses external
solutions.

Best Regards,
Alon Bar-Lev.
