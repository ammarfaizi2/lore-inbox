Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263762AbUAHHcP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 02:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263792AbUAHHcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 02:32:15 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:61882 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263762AbUAHHcN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 02:32:13 -0500
Subject: Re: Strange IDE performance change in 2.6.1-rc1 (again)
From: Ram Pai <linuxram@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paolo Ornati <ornati@lycos.it>, gandalf@wlug.westbo.se,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040107155729.7e737c36.akpm@osdl.org>
References: <200401021658.41384.ornati@lycos.it>
	 <200401071559.16130.ornati@lycos.it>
	 <1073503421.10018.17.camel@dyn319250.beaverton.ibm.com>
	 <200401072112.35334.ornati@lycos.it>
	 <20040107155729.7e737c36.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1073547103.10018.29.camel@dyn319250.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Jan 2004 23:31:44 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-07 at 15:57, Andrew Morton wrote:
> Paolo Ornati <ornati@lycos.it> wrote:
> >
> > I haven't done a lot of tests but it seems to me that the changes in 
> > mm/filemap.c are the only things that influence the sequential read 
> > performance on my disk.
> 
> The fact that this only happens when reading a blockdev (true?) is a big
> hint.   Maybe it is because regular files implement ->readpages.
> 
> If the below patch makes read throughput worse on regular files too then
> that would confirm the idea.

No the throughput did not worsen with the patch, for regular files(on
scsi disk). Lets see what Paolo Ornati finds.

Its something to do with the changes in filemap.c,
RP

