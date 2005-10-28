Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030522AbVJ1TC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030522AbVJ1TC1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 15:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030574AbVJ1TC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 15:02:27 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:1233 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1030522AbVJ1TC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 15:02:26 -0400
Date: Fri, 28 Oct 2005 21:02:25 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Paulo da Silva <psdasilva@esoterica.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Learning ext2 fs
Message-ID: <20051028190225.GC1269@wohnheim.fh-wedel.de>
References: <436116DC.6030104@esoterica.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <436116DC.6030104@esoterica.pt>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 October 2005 19:05:16 +0100, Paulo da Silva wrote:
> 
> I am reading the ext2 fs code. One of my purposes
> is to save the original data of a file to another file
> just before it is changed by write/mmap/whatever.
> Because of mmap (any other reasons?) I thought
> of doing this at "ext2-writepage" or/and
> "ext2-writepages".
> 
> Is this the right place?

Maybe, but the error handling will drive you insane.  My approach was
to copy on open, not on write.  See
http://wohnheim.fh-wedel.de/~joern/cowlink/

Jörn

-- 
Happiness isn't having what you want, it's wanting what you have.
-- unknown
