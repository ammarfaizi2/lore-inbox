Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932894AbWKQNzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932894AbWKQNzM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 08:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbWKQNzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 08:55:12 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:48358 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1755098AbWKQNzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 08:55:10 -0500
Message-ID: <455DBF3D.40801@s5r6.in-berlin.de>
Date: Fri, 17 Nov 2006 14:55:09 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Randy Dunlap <randy.dunlap@oracle.com>
CC: lkml <linux-kernel@vger.kernel.org>, zippel@linux-m68k.org,
       jejb <james.bottomley@steeleye.com>
Subject: Re: how to handle indirect kconfig dependencies
References: <20061116200741.fb607fe4.randy.dunlap@oracle.com>
In-Reply-To: <20061116200741.fb607fe4.randy.dunlap@oracle.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
> I have a (randconfig) build of 2.6.19-rc5-mm2 with:
[...]
> so the question is:
> (How) can kconfig follow the dependency chain and either
> - prevent this odd config combination or
> - see that 'select DEBUG_FS' implies 'select SYSFS' and then enable SYSFS
> ?
> 
> I don't believe that the right answer is to add
> 	depends on SYSFS
> to DEBUG_READAHEAD.

I know this doesn't concludingly answer your question, but: All of the
various shipped tools to generate .config need to be fixed to recognize
"select" to imply a dependency like "depends on" does.

[...]
> ~Randy [or just kill off select]

Or this. ("select" appears to be useful for dialog driven creation of
.config in cases where developers are able to predetermine preferences
of users --- nothing more and nothing less.)
-- 
Stefan Richter
-=====-=-==- =-== =---=
http://arcgraph.de/sr/
