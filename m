Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270430AbUJUFSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270430AbUJUFSu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 01:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270627AbUJUFPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 01:15:11 -0400
Received: from 209-128-98-078.BAYAREA.NET ([209.128.98.78]:11675 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S270637AbUJUFL2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 01:11:28 -0400
Message-ID: <417744FD.1000008@zytor.com>
Date: Wed, 20 Oct 2004 22:11:25 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: Michael Clark <michael@metaparadigm.com>, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <20041016062512.GA17971@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com> <20041017133537.GL7468@marowsky-bree.de> <cl6lfq$jlg$1@terminus.zytor.com> <4176DF84.4050401@nortelnetworks.com> <4176E001.1080104@zytor.com> <41772674.50403@metaparadigm.com> <417736C0.8040102@zytor.com> <417743EF.90604@nortelnetworks.com>
In-Reply-To: <417743EF.90604@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> H. Peter Anvin wrote:
> 
>> The whole point is that it doesn't break the *documented* interface.
> 
> 
> In my view (and apparently others, as has been verified in current apps 
> using blocking sockets), current behaviour *does* break the documented 
> interface.
> 
> The man page for select says:
> 
> "Those  listed  in  readfds  will  be watched  to  see if characters 
> become available for reading (more precisely, to see if a read will not 
> block..."
> 
> If I'm the only one touching the socket, select returns with it 
> readable, and I block when calling recvmsg, then by definition that 
> behaviour does not match the documented interface.
> 

I'm talking about returning -1, EIO.

	-hpa
