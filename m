Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbUCCKId (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 05:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbUCCKId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 05:08:33 -0500
Received: from uslink-66.173.43-133.uslink.net ([66.173.43.133]:29316 "EHLO
	dingdong.cryptoapps.com") by vger.kernel.org with ESMTP
	id S262402AbUCCKIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 05:08:31 -0500
Date: Wed, 3 Mar 2004 02:08:30 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Anton Petrusevich <casus@att-ltd.biz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ftruncate64
Message-ID: <20040303100830.GA16569@dingdong.cryptoapps.com>
References: <200402260523.10394.casus@att-ltd.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402260523.10394.casus@att-ltd.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 05:23:10AM +0600, Anton Petrusevich wrote:

> ftruncate64(1, 2199023255552)           = -1 EFBIG (File too large)

Depends on your fs, some fs's will allow you to create much larger
files that others:

cw@pain:~$ truncate -c -s100t big-file
cw@pain:~$ ls -lh big-file
-rw-r--r--    1 cw       cw           100T Mar  3 02:05 big-file


Note, you might need a 64-bit system to be able to write to all of
that because the index into the buffer-cache is an unsigned long.  For
me on my notebook I can't write past 8T.


  --cw
