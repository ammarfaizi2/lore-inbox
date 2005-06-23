Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVFWDjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVFWDjK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 23:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVFWDjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 23:39:09 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:49087 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261976AbVFWDjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 23:39:05 -0400
Message-ID: <42BA2ED5.6040309@namesys.com>
Date: Wed, 22 Jun 2005 20:39:01 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Alexander Zarochentsev <zam@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       reiserfs-list@namesys.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: reiser4 plugins
References: <20050620235458.5b437274.akpm@osdl.org> <42B8B9EE.7020002@namesys.com> <42B8BB5E.8090008@pobox.com> <200506221824.32995.zam@namesys.com> <20050622142947.GA26993@infradead.org>
In-Reply-To: <20050622142947.GA26993@infradead.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correct me if I am wrong:

What exists currently in VFS are vector instances, not classes. Plugins,
selected by pluginids, are vector classes, with each pluginid selecting
a vector class. You propose to have the vector class layer (aka plugin
layer) in reiser4 export the vector instance to VFS for VFS to handle
for each object, rather than having VFS select reiser4 and reiser4
selecting a vector class (aka plugin) which selects a method.

If we agree on the above, then I will comment further.

Christoph Hellwig wrote:

>On Wed, Jun 22, 2005 at 06:24:32PM +0400, Alexander Zarochentsev wrote:
>  
>
>>Reiser plugins are for the same.  Would you agree with reiser4 plugin design 
>>if the plugins will not dispatch VFS object methods calls by themselves but 
>>set ->foo_ops fileds instead?  I guess you don't like to have the two 
>>dispatching systems at the same level.
>>    
>>
>
>That is exactly the point I want to make.  I haven't looked at the design
>in detail for a long time, but schemes to allow different object to have
>different operation vectors is a good idea.  We already have that to
>varying degrees in all filesystems, and making that more formal is a good
>thing.  
>
>
>  
>

