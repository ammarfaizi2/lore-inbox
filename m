Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264718AbUD1KJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264718AbUD1KJb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 06:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264719AbUD1KJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 06:09:31 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:41398 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264718AbUD1KJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 06:09:29 -0400
Date: Wed, 28 Apr 2004 12:09:16 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Lang <dlang@digitalinsight.com>
Cc: Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: File system compression, not at the block layer
Message-ID: <20040428100916.GA29219@wohnheim.fh-wedel.de>
References: <408951CE.3080908@techsource.com> <Pine.LNX.4.58.0404271753380.20613@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0404271753380.20613@dlang.diginsite.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 April 2004 18:00:11 -0700, David Lang wrote:
> 
> to answer the fundamental question that was asked in this thread but not
> answered.
> 
> the reason why we want to compress at the block level instead of over the
> entire file is that sometimes we want to do random seeks into the middle
> of the file or replace a chunk in the middle of a file (edits, inserts,
> etc). by doing the compression in a block the worst that you have to do is
> to read that one block, decompress it and get your data out (or modify the
> block, compress it and put it back on disk). if your unit of compression
> is the entire file each of these options will require manipulating basicly
> the entire file (Ok, reads you can possibly stop after you found your
> data)

*IF* your unit of compression...

If that is the complete block device, you're stupid and deserve what
you get.  If it is the file, same thing.  No difference.

Do it at the file system level or don't do it at all.

Jörn

-- 
Don't worry about people stealing your ideas. If your ideas are any good,
you'll have to ram them down people's throats.
-- Howard Aiken quoted by Ken Iverson quoted by Jim Horning quoted by
   Raph Levien, 1979
