Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbULUUwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbULUUwv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 15:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbULUUwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 15:52:51 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:36541 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261852AbULUUwt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 15:52:49 -0500
Date: Tue, 21 Dec 2004 21:48:53 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Mark Broadbent <markb@wetlettuce.com>
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Lockup with 2.6.9-ac15 related to netconsole
Message-ID: <20041221204853.GA20869@electric-eye.fr.zoreil.com>
References: <34721.192.102.214.6.1103274614.squirrel@webmail.wetlettuce.com> <20041217215752.GP2767@waste.org> <20041217233524.GA11202@electric-eye.fr.zoreil.com> <36901.192.102.214.6.1103535728.squirrel@webmail.wetlettuce.com> <20041220211419.GC5974@waste.org> <20041221002218.GA1487@electric-eye.fr.zoreil.com> <20041221005521.GD5974@waste.org> <52121.192.102.214.6.1103624620.squirrel@webmail.wetlettuce.com> <20041221123727.GA13606@electric-eye.fr.zoreil.com> <49295.192.102.214.6.1103635762.squirrel@webmail.wetlettuce.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49295.192.102.214.6.1103635762.squirrel@webmail.wetlettuce.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Broadbent <markb@wetlettuce.com> :
[...]
> Using the patch supplied I get no hang, just the message 'netconsole
> raced' output to the console and the packet capture proceeds as normal.
> Thanks

The patch is more a bandaid for debugging than a real fix. The netconsole
will drop some messages until its locking is fixed

If you can issue one more test, I'd like to know if some messages appear
on the VGA console around the time at which tcpdump is started (the test
assumes that netconsole is not used/insmoded at all). Please check that
the console log_level is set high enough as it will be really disappointing
if nothing appears :o)

--
Ueimor
