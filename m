Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264492AbTH2Jw7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 05:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264497AbTH2Jw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 05:52:59 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:44713 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264492AbTH2Jw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 05:52:57 -0400
Subject: Re: [RFC] /proc/ide/hdx/settings with ide-default pseudo-driver is
	a 2.6/2.7 show-stopper
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: andersen@codepoet.org
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <20030829011910.GA19351@codepoet.org>
References: <200308281646.16203.bzolnier@elka.pw.edu.pl>
	 <1062083581.24982.21.camel@dhcp23.swansea.linux.org.uk>
	 <200308281747.11359.bzolnier@elka.pw.edu.pl>
	 <20030829011910.GA19351@codepoet.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062150717.26761.6.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 29 Aug 2003 10:51:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-08-29 at 02:19, Erik Andersen wrote:
> Make an interface whereby ide-cdrom (and ide-disk, etc) can walk
> the list of all unclaimed devices (i.e. devices owned by
> ide-default), check they are of the correct type, and claim them
> (thereby removing them from the ide-default driver).  When
> unregistering, reverse the process and give the device back to
> ide-default...  i.e. make ide-default a holding pen for unclaimed
> devices,

Thats how the current setup works (at least in 2.4). ide-default is
the driver for the old cases where driver = NULL, eliminating the
special cases and bugs. 

