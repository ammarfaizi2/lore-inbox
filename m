Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWHPT2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWHPT2g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 15:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWHPT2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 15:28:35 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:36615 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932191AbWHPT2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 15:28:34 -0400
Message-ID: <44E37179.5020404@shadowen.org>
Date: Wed, 16 Aug 2006 20:26:49 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm1 -- new depancy on curses development
References: <20060813012454.f1d52189.akpm@osdl.org> <44E2E867.2050508@shadowen.org> <20060816183348.GA5852@mars.ravnborg.org>
In-Reply-To: <20060816183348.GA5852@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Wed, Aug 16, 2006 at 10:41:59AM +0100, Andy Whitcroft wrote:
>> Andrew Morton wrote:
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
>>> git-lxdialog.patch
>> This tree seems to change the Makefile dependancies in the kconfig 
>> subdirectory such that a plain compile of the kernel leads to an attempt 
>> to build the menuconfig targets.  This in turn adds a new dependancy on 
>> the curses development libraries.
> What I see is that "make defconfig" builds _all_ *config targets -
> strange...

Well it could be trying to build them all for me too, but as I don't 
have curses development libraries it would fail at that point.  I don't 
think we want it to build the ones its not using.  Thats daft :).

> Hmmm, why does git pick up my hostname (mars)? Have I configured
> somethign wrong (not in git but my gentoo system)?

I had to configure my local git repo:

	git repo-config user.name 'Foo Bar'
	git repo-config user.email 'foo@bar.org'

