Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbTDOTyt (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 15:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264056AbTDOTyt 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 15:54:49 -0400
Received: from zeke.inet.com ([199.171.211.198]:35288 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id S264054AbTDOTys 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 15:54:48 -0400
Message-ID: <3E9C664A.503@inet.com>
Date: Tue, 15 Apr 2003 15:06:34 -0500
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: .section ... "ax" vs  #alloc, #execinstr
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the assembly files use
.section        ".start", "ax"
and others use
.section ".start", #alloc, #execinstr
(and not just for .start, try
find -name \*.S | xargs grep -e '\.section'
)

These appear to be equivelent, if not somebody clue me in please. :) 
Which is the prefered form?  The latter seems to provide a bit more for 
the human, so I'd vote that direction... ;)

Thanks,

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

