Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267370AbUI0VFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267370AbUI0VFT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 17:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267381AbUI0VEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 17:04:10 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:43150 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267374AbUI0VBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 17:01:49 -0400
Message-ID: <41588073.70102@austin.ibm.com>
Date: Mon, 27 Sep 2004 16:04:51 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ray Bryant <raybry@sgi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Simplified Readahead
References: <4152F46D.1060200@austin.ibm.com>	<20040923194216.1f2b7b05.akpm@osdl.org>	<41543FE2.5040807@austin.ibm.com> <20040924150523.4853465b.akpm@osdl.org> <4154A5FF.6040206@austin.ibm.com> <4158782B.9000509@sgi.com>
In-Reply-To: <4158782B.9000509@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Bryant wrote:

> Hi Steve,
>
> On question I have (and I'm sorry, I haven't had time to look at your
> patch to sort this out) is what happens if the user supplies a rather
> serious I/O size, will you read ahead multiples of that, or what
> happens?  Or, for that matter, how well will it perform?

Same behavior as the old code.  I/Os are broken up into at most 
max_readahead size pieces.  In the case of the old code only 1 of these 
could be outstanding. In the new code there could be at most 2 
outstanding at any point in time.

>
> I've heard about HPC applications for IRIX that issue a 2GB read.  :-)

This is why for these types of applications, especially on RAID arrays, 
you need to set max_readahead into the MBs. (But that is a different topic).

Steve

