Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbVJQSV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbVJQSV4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 14:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbVJQSV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 14:21:56 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:44268 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932166AbVJQSVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 14:21:55 -0400
Date: Mon, 17 Oct 2005 23:45:42 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Eric Dumazet <dada1@cosmosbay.com>, Jean Delvare <khali@linux-fr.org>,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
Message-ID: <20051017181542.GE13665@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org> <JTFDVq8K.1129537967.5390760.khali@localhost> <20051017084609.GA6257@in.ibm.com> <43536A6C.102@cosmosbay.com> <20051017103244.GB6257@in.ibm.com> <Pine.LNX.4.64.0510170829000.23590@g5.osdl.org> <4353CADB.8050709@cosmosbay.com> <Pine.LNX.4.64.0510170911370.23590@g5.osdl.org> <20051017162930.GC13665@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051017162930.GC13665@in.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 09:59:30PM +0530, Dipankar Sarma wrote:
> On Mon, Oct 17, 2005 at 09:16:25AM -0700, Linus Torvalds wrote:
> 
> At the moment however I do have another concern - open/close taking too
> much time as I mentioned in an earlier email. It is nearly 4 times
> slower than 2.6.13. So, that is first up in my list of things to
> do at the moment.

Please ignore this. This is a big Doh! slab debugging snuck into
my config file because I was trying to track down the 
"bad page state" problem again. Without it, open/close in 2.6.14-rc1
is just as fast as 2.6.13 - ~3 microseconds per pair.

Thanks
Dipankar
