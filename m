Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269173AbUIYBra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269173AbUIYBra (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 21:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269181AbUIYBra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 21:47:30 -0400
Received: from scrye.com ([216.17.180.1]:36768 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S269173AbUIYBrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 21:47:11 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Fri, 24 Sep 2004 19:45:42 -0600
From: Kevin Fenzi <kevin@scrye.com>
To: ncunningham@linuxmail.org
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc2-mm1 swsusp bug report.
In-Reply-To: <1096069216.3591.16.camel@desktop.cunninghams>
References: <20040924021956.98FB5A315A@voldemort.scrye.com>
	<20040924143714.GA826@openzaurus.ucw.cz>
	<20040924210958.A3C5AA2073@voldemort.scrye.com>
	<1096069216.3591.16.camel@desktop.cunninghams>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Message-Id: <20040925014546.200828E71E@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Nigel" == Nigel Cunningham <ncunningham@linuxmail.org> writes:

Nigel> Hi.  On Sat, 2004-09-25 at 07:09, Kevin Fenzi wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> >>>>> "Pavel" == Pavel Machek <pavel@ucw.cz> writes:
>> 
Pavel> Hi!
>> >> Was trying to swsusp my 2.6.9-rc2-mm1 laptop tonight. It churned
>> >> for a while, but didn't hibernate. Here are the messages.
>> >> 
>> >>
>> ....................................................................................................
>> >> .........................swsusp: Need to copy 34850 pages Sep 23
>> >> 16:53:37 voldemort kernel: hibernate: page allocation >>
>> failure. order:8, mode:0x120 Sep 23 16:53:37 voldemort kernel:
Pavel> Out of memory... Try again with less loaded system.
>> The system was no more loaded than usual. I have 1GB memory and 4GB
>> of swap defined. I almost never touch swap. It might have been
>> 100mb into the 4Gb of swap when this happened.
>> 
>> What would cause it to be out of memory? swsup needs to be
>> reliable... rebooting when you are using your memory kinda defeats
>> the purpose of swsusp.

Nigel> The problem isn't really that you're out of memory. Rather, the
Nigel> memory is so fragmented that swsusp is unable to get an order 8
Nigel> allocation in which to store its metadata. There isn't really
Nigel> anything you can do to avoid this issue apart from eating
Nigel> memory (which swsusp is doing anyway).

Odd. I have never run into this before with either swsusp2 or
swsusp1. 

What causes memory to be so fragmented? 
Nothing can be done to prevent it?

Nigel> Regards,
Nigel> Nigel

kevin


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFBVM3K3imCezTjY0ERAh75AJ43eMOWlXc2HFQGhTBfgO9G+nI8tACgl7t9
bc6Lo+2guz9WRcu5FhInWMc=
=hunr
-----END PGP SIGNATURE-----
