Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264151AbTKJXG4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 18:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264157AbTKJXGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 18:06:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:47054 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264151AbTKJXGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 18:06:54 -0500
Subject: Re: 2.6.0-test9-mm2 - AIO tests still gets slab corruption
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>, Suparna Bhattacharya <suparna@in.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <20031104225544.0773904f.akpm@osdl.org>
References: <20031104225544.0773904f.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1068505605.2042.11.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Nov 2003 15:06:45 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

test9-mm2 is still getting slab corruption with AIO:

Maximal retry count.  Bytes done 0
Slab corruption: start=dc70f91c, expend=dc70f9eb, problemat=dc70f91c
Last user: [<c0192fa3>](__aio_put_req+0xbf/0x200)
Data: 00 01 10 00 00 02 20 00 *********6C ******************************A5
Next: 71 F0 2C .A3 2F 19 C0 71 F0 2C .********************
slab error in check_poison_obj(): cache `kiocb': object was modified after freeing

With suparna's retry-based-aio-dio patch, there are no kernel messages
and the tests do not see any uninitialized data.

Any reason not to add suparna's patch to -mm to fix these problems?

Thanks,

Daniel

