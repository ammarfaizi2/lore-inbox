Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbUKSBOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbUKSBOa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 20:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbUKSBO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 20:14:29 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:55664 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263034AbUKSBOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 20:14:14 -0500
Message-ID: <419D48DE.6030703@yahoo.com.au>
Date: Fri, 19 Nov 2004 12:14:06 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: ak@suse.de, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: let x86_64 no longer define X86
References: <20041119005117.GM4943@stusta.de>
In-Reply-To: <20041119005117.GM4943@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

> And if you want to support both older and more recent kernels, the 
> following dependencies will be correct both before and after this 
> change:
> - (X86 && !X86_64)
> - (X86 && X86_64)
> 

This last one surely can't be correct before *and* afterwards. But even in
the current system, it is a pretty perverse thing to check for. I guess you
meant:

(X86 || X86_64)
