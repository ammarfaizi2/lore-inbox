Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264315AbUDOPah (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 11:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264327AbUDOPah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 11:30:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:59307 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264315AbUDOPa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 11:30:26 -0400
Message-Id: <200404151530.i3FFUI226872@mail.osdl.org>
Date: Thu, 15 Apr 2004 08:30:15 -0700 (PDT)
From: markw@osdl.org
Subject: Re: 2.6.5-mm5
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, mingo@elte.hu
In-Reply-To: <20040412221717.782a4b97.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have more results with DBT-2 on my 4-way Xeon system:
	http://developer.osdl.org/markw/fs/dbt2_project_results.html

It doesn't look like the latest cpu scheduler work is helping this
workload.  I've also made sure that the database was set to use fsync
instead of fdatasync so you can see if those fsync speedup patches are
offering anything with this workload too.

           ext2  ext3
2.6.5-mm5  2165  1933
2.6.5-mm4  2180
2.6.5-mm3  2165  1930
2.6.5      2385

Mark
