Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266401AbUAIC2X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 21:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266415AbUAIC2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 21:28:22 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:52688 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266401AbUAIC1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 21:27:46 -0500
Date: Fri, 9 Jan 2004 03:27:42 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, Jan Kara <jack@ucw.cz>
Subject: Re: [2.4 patch] fix CONFIG_QFMT_V2 description
Message-ID: <20040109022742.GA1440@fs.tum.de>
References: <20040107155940.GB11523@fs.tum.de> <20040107161110.A30210@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107161110.A30210@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 04:11:10PM +0000, Christoph Hellwig wrote:
> On Wed, Jan 07, 2004 at 04:59:40PM +0100, Adrian Bunk wrote:
> > In 2,4, the CONFIG_QFMT_V2 short description talks about a
> > "VFS v0 quota format". Is this really correct, or is the patch below 
> > that uses the "Quota format v2 support" text from 2.6 instead correct?
> 
> I think you should ask Jan Kara instead what he prefers.  This VFS v0
> stuff is his invention.  Personally I'm a little confused about the proper
> naming, too.

Jan, could you check whether the patch below is correct?

TIA
Adrian

--- linux-2.4.25-pre4-full/fs/Config.in.old	2004-01-07 16:46:06.000000000 +0100
+++ linux-2.4.25-pre4-full/fs/Config.in	2004-01-07 16:49:29.000000000 +0100
@@ -5,7 +5,7 @@
 comment 'File systems'
 
 bool 'Quota support' CONFIG_QUOTA
-dep_tristate '  VFS v0 quota format support' CONFIG_QFMT_V2 $CONFIG_QUOTA
+dep_tristate '  Quota format v2 support' CONFIG_QFMT_V2 $CONFIG_QUOTA
 
 tristate 'Kernel automounter support' CONFIG_AUTOFS_FS
 tristate 'Kernel automounter version 4 support (also supports v3)' CONFIG_AUTOFS4_FS
--- linux-2.4.25-pre4-full/Documentation/Configure.help.old	2004-01-07 16:50:05.000000000 +0100
+++ linux-2.4.25-pre4-full/Documentation/Configure.help	2004-01-07 16:50:37.000000000 +0100
@@ -13628,7 +13628,7 @@
   <http://www.tldp.org/docs.html#howto>. Probably the quota
   support is only useful for multi user systems. If unsure, say N.
 
-VFS v0 quota format support
+Quota format v2 support
 CONFIG_QFMT_V2
   This quota format allows using quotas with 32-bit UIDs/GIDs. If you
   need this functionality say Y here. Note that you will need latest
