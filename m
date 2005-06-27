Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbVF0L2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVF0L2n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 07:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVF0L2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 07:28:42 -0400
Received: from relay2.beelinegprs.ru ([217.118.71.5]:45790 "EHLO
	relay1.beelinegprs.ru") by vger.kernel.org with ESMTP
	id S261872AbVF0L2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 07:28:41 -0400
From: Alexander Zarochentsev <zam@namesys.com>
Organization: namesys
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: reiser4 plugins
Date: Mon, 27 Jun 2005 15:28:49 +0400
User-Agent: KMail/1.8
Cc: reiserfs-list@namesys.com, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org
References: <20050620235458.5b437274.akpm@osdl.org> <200506271330.07451.zam@namesys.com> <20050627094223.GB5470@infradead.org>
In-Reply-To: <20050627094223.GB5470@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506271528.49674.zam@namesys.com>
X-SpamTest-Info: Profile: Formal (248/050617)
X-SpamTest-Info: Profile: Detect Hard No RBL (4/030526)
X-SpamTest-Info: Profile: SysLog
X-SpamTest-Info: Profile: Marking Spam - Subject (2/030321)
X-SpamTest-Status: Not detected
X-SpamTest-Version: SMTP-Filter Version 2.0.0 [0129], SpamtestISP/Release
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 June 2005 13:42, Christoph Hellwig wrote:
> On Mon, Jun 27, 2005 at 01:30:06PM +0400, Alexander Zarochentsev wrote:
> > -- procfs  has seq_file and sysconfig interfaces below the VFS and l-k
> > people do not complain each day about layering violation ;-)  Procfs is
> > taken as an example because it deals with objects of different types,
> > actually anybody may create own procfs objects more or less general way.
>
> seq_file actually works at the file_operations level, that's exactly
> what I'm telling you to do.  The old sub-callbacks are on their way out.

not exactly.  I meant that seq_file has its own VFS-like thing struct 
seq_operations.

So I may assume that having own objects and their operations is allowed.  The 
complains are about adding unnecessary level of indirection in the trivial 
reiser4 wrappers as reiser4_write().   

> > I don't belive that you want to see all reiser4-specific things as item
> > plugins, disk format plugins in the VFS.
>
> If you'd read the previous discussions you'd see that no one complained
> about disk format plugins.

