Return-Path: <linux-kernel-owner+w=401wt.eu-S1762610AbWLJVLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762610AbWLJVLE (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 16:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762616AbWLJVLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 16:11:04 -0500
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:48119 "HELO
	smtp114.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1762610AbWLJVLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 16:11:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=Qeceq7le231AiKBwqS+FTB7NBLzZ4nxhrCh9PRyC9D+YsoRMUfZsa8sUDprk5VQBE9hv2zna+FleegLwe5Adz69L+mEumqAW5O984uqnVTSLWMCUs2f6GOyjdsXnGZ/40GrCI9/hWNiGYeKs5fNEZZrtlTCo4dLj40FwhWU5/Uc=  ;
X-YMail-OSG: ArGjoMkVM1ngsvpwfAfQkuQvx.hJ9iTy2GTnyrALDm5eJ6S7v76jeQDCZezD8EoSbUek7uQz5qYkcuA7JOsV0ISqGNaLxvOUuKcwTSVn81gl5Q_eb8LqXdY6pa06YLR_nemw903sHSGnu8oQwFd9oNpn4Kk4B2tpXcwko3VBCQFdj4rDFvWZ9CSCbVYL
From: David Brownell <david-b@pacbell.net>
To: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [patch 2.6.19-git] watchdog:  at91_wdt build fix
Date: Sun, 10 Dec 2006 13:10:50 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Andrew Victor <andrew@sanpeople.com>
References: <20061208072722.85DCE1EB27F@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <20061210192348.GA2507@infomag.infomag.iguana.be>
In-Reply-To: <20061210192348.GA2507@infomag.infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612101310.51286.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 December 2006 11:23 am, Wim Van Sebroeck wrote:
> Hi David,
> 
> > Recent miscdev changes broke various drivers, so they won't build.
> > This fixes another one.
> 
> See also Andrew Victor's patch (dated 04/Dec/2006) in the
> linux-2.6-watchdog tree. It's indeed the at91rm9200_wdt, the mpcore_wdt
> and the omap_wdt that are affected by the miscdev changes

I was just following the "fix brown paper bags ASAP" policy.
One that seems followed less closely than usual in the current
kernel tree.  :(


> (See Driver core: change misc class_devices to be real devices
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=94fbcded4ea0dc14cbfb222a5c68372f150d1476 )

Hmm, I'm a bit surprised that not all the watchdog drivers have
this issue.  Is the problem that most of them don't actually
adhere to the driver model ... that is, most don't have any kind
of (platform or other) device backing the watchdog?

- Dave
