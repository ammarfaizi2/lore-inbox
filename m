Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263836AbUASVx4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 16:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265056AbUASVx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 16:53:56 -0500
Received: from dh197.citi.umich.edu ([141.211.133.197]:50567 "EHLO
	nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S263836AbUASVxw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 16:53:52 -0500
Subject: Re: Awful NFS performance with attached test program
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: jlnance@unity.ncsu.edu
Cc: linux-kernel@vger.kernel.org, cmp@synopsys.com
In-Reply-To: <20040119211649.GA20200@ncsu.edu>
References: <20040119211649.GA20200@ncsu.edu>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1074549226.1560.59.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 19 Jan 2004 16:53:46 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 19/01/2004 klokka 16:16, skreiv jlnance@unity.ncsu.edu:
> Hello All,
>     The attached program demonstrates a problem I am having writing to
> files on an NFS file system.  It works by creating a file, and then
> seeking through the file to update it.  The problem I am seeing is that
> the seek/update stage takes more than 10X as long as the amount of time
> required to initially create the file.  And its not even seeking in
> some strange pattern.
> 
>     I am running this with a 2.4.20 (red hat patched) kernel.  I have not
> tried it with 2.6.  I have played with various mount options, but they
> do not seem to make much difference.  Here is one example that I used:

So you are surprised that writing the same dataset by putting one
integer onto each kernel page takes much more time than placing the
entire dataset onto just a few kernel pages? 'cos I'm not...

Have a look at the nfsstat output and you'll see what I mean. Doing the
former will necessarily end up generating *a lot* more NFS write
requests.

Cheers,
  Trond
