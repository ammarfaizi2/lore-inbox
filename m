Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267472AbUG2Rw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267472AbUG2Rw1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 13:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265962AbUG2RwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 13:52:20 -0400
Received: from outmx002.isp.belgacom.be ([195.238.3.52]:25275 "EHLO
	outmx002.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S267505AbUG2Rnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 13:43:50 -0400
Subject: Re: [PATCHSET 2.6.7-rc2-ff3] Kernel webconfig
From: FabF <fabian.frederick@skynet.be>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040729100225.0e0b9aef.rddunlap@osdl.org>
References: <1089211577.3692.46.camel@localhost.localdomain>
	 <20040728095256.57aeed52.rddunlap@osdl.org>
	 <1091049074.7462.1.camel@localhost.localdomain>
	 <20040729100225.0e0b9aef.rddunlap@osdl.org>
Content-Type: text/plain
Message-Id: <1091123009.2334.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 29 Jul 2004 19:43:30 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy,

You're absolutely right ! I forgot to talk about that mandatory point :

Here's httpd.conf additions :

ScriptAlias /cgi-bin/ "/usr/src/linux-2.6.7-rc2-ff1/"

<Directory "/usr/src/linux-2.6.7-rc2-ff1/">
    AllowOverride None
    Options None
    Order allow,deny
    Allow from all
</Directory>

i.e. http://localhost/cgi-bin/wconf is mapped to wconf binary which is
generated in linux tree root.

Note that we could work another way around e.g. 
	-Have CGI in apache original cgi-bin path
	-Place some conf file with kernel tree.
... That said, it's only in proto state :)

Regards,
FabF

	
On Thu, 2004-07-29 at 19:02, Randy.Dunlap wrote:
> On Wed, 28 Jul 2004 23:11:15 +0200 FabF wrote:
> 
> | Randy,
> | 
> | 	It's there again :)
> | 	http://fabian.unixtech.be/kernel/webconfig/
> | 
> | 	Sorry for inconvenience but I removed it as I had 0 reaction.
> 
> Hi Fabian,
> 
> I've built it, but I don't know how to invoke it.
> I have apache2 running and I added your cgi activation comments
> to apache's local config file.  How do I invoke 'wconf' from
> my browser?
> 
> Thanks,
> ~Randy


