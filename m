Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVFZSRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVFZSRc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 14:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVFZSRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 14:17:31 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:11216 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261544AbVFZSOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 14:14:46 -0400
Date: Sun, 26 Jun 2005 11:14:35 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: reiser@namesys.com, zam@namesys.com, jgarzik@pobox.com,
       reiserfs-list@namesys.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: reiser4 plugins
Message-Id: <20050626111435.6c5d54c8.rdunlap@xenotime.net>
In-Reply-To: <20050626164606.GA18942@infradead.org>
References: <20050620235458.5b437274.akpm@osdl.org>
	<42B8B9EE.7020002@namesys.com>
	<42B8BB5E.8090008@pobox.com>
	<200506221824.32995.zam@namesys.com>
	<20050622142947.GA26993@infradead.org>
	<42BA2ED5.6040309@namesys.com>
	<20050626164606.GA18942@infradead.org>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jun 2005 17:46:06 +0100 Christoph Hellwig wrote:

| On Wed, Jun 22, 2005 at 08:39:01PM -0700, Hans Reiser wrote:
| > Correct me if I am wrong:
| > 
| > What exists currently in VFS are vector instances, not classes. Plugins,
| > selected by pluginids, are vector classes, with each pluginid selecting
| > a vector class. You propose to have the vector class layer (aka plugin
| > layer) in reiser4 export the vector instance to VFS for VFS to handle
| > for each object, rather than having VFS select reiser4 and reiser4
| > selecting a vector class (aka plugin) which selects a method.
| > 
| > If we agree on the above, then I will comment further.
| 
| I'm a bit confused about what you're saying here.  What does the 'vector'
| in all these expressions mean?
| 
| In OO terminology our *_operation structures are interfaces.  Each particular
| instance of such a struct that is filled with function pointers is a class.
| Each instance of an inode/file/dentry/superblock/... that uses these operation
| vectors is an object.
| 
| What I propose (or rather demand ;-)) is that you don't duplicate this
| infrastructure, and add another dispath layer below these objects but instead
| re-use it for what it is done and only handle things specific to reiser4
| in your own code. 

I think that what Hans is trying to say is that the functionality
that is handled by plugin_operations are a different dimension or
vector from the inode/file/dentry etc. operations.
Whether he is right or not is part of the discussion.
and "plugin" is a bad name :(

Is part of the problem that plugins are too extensible?
I.e., the plugin_operations methods can do almost anything?

I would want to see a list of methods that should be supported and then
a reasonable infrastructure for supporting those.
Pick one (like metadata) and drill down on how to support that.

---
~Randy
