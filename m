Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbTBNQqI>; Fri, 14 Feb 2003 11:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbTBNQqI>; Fri, 14 Feb 2003 11:46:08 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:28032
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261302AbTBNQqH>; Fri, 14 Feb 2003 11:46:07 -0500
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rusty Lynch <rusty@linux.co.intel.com>
Cc: Matt Porter <porter@cox.net>, Scott Murray <scottm@somanetworks.com>,
       Patrick Mochel <mochel@osdl.org>, Dave Jones <davej@codemonkey.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1045236757.12974.14.camel@vmhack>
References: <Pine.LNX.4.33.0302131317210.1133-100000@localhost.localdomain>
	 <Pine.LNX.4.44.0302131603500.23407-100000@rancor.yyz.somanetworks.com>
	 <20030213155817.B1738@home.com>  <1045173941.1009.4.camel@vmhack>
	 <1045183679.1009.7.camel@vmhack>
	 <1045234137.7958.17.camel@irongate.swansea.linux.org.uk>
	 <1045236757.12974.14.camel@vmhack>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045245352.1353.35.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 14 Feb 2003 17:55:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-14 at 15:32, Rusty Lynch wrote:
> Since only one driver can register as the /dev/watchdog (ie
> major=10/minor=130 char device), would it be better if:
> 
> * the first watchdog driver to register with the base also gets
> registered as the watchdog misc device, and when that driver unregisters
> then the second watchdog to register now gets registered as the misc
> device, etc.
> * each watchdog driver gets an additional sysfs file named 'misc', where
> writing a '1' to the file causes the driver to become the registered
> misc watchdog device.
> * something else

I had hoped we'd get some kind of sanity and 32bit dev_t by now at which
point watchdogs belong on a major with /dev/watchdog0/1/2/3/... I dont
think you need to care about that for now. Sysfs doesn't help here in
the general case as it lacks persistant file permissions, but where it
is used the user can simply make /dev/watchdog a link into sysfs and
nothing has to be done by the driver

Alan

