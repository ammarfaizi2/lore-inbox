Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265225AbUATIgO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 03:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUATIgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 03:36:14 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:32661 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265225AbUATIgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 03:36:09 -0500
Message-ID: <400CE873.3000204@labs.fujitsu.com>
Date: Tue, 20 Jan 2004 17:36:03 +0900
From: Tsuchiya Yoshihiro <tsuchiya@labs.fujitsu.com>
Reply-To: tsuchiya@labs.fujitsu.com
Organization: Fujitsu Labs
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: filesystem bug?
References: <4007537F.4070609@labs.fujitsu.com>	 <1074256175.4006.24.camel@sisko.scot.redhat.com>	 <400B8CD4.8000503@labs.fujitsu.com> <1074517928.3694.22.camel@sisko.scot.redhat.com>
In-Reply-To: <1074517928.3694.22.camel@sisko.scot.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie wrote:

> Other than 2.4.20-28.9, since they have been running for three days,
>
>>they seems nice at this point.
>>
>>What exactly is the race condition between read_inode() and
>>clear_inode() you have
>>mentioned?
>>    
>>
>
>This one:
>
>http://linux.bkbits.net:8080/linux-2.4/patch@1.1136.67.1
>  
>

Thank you. I think this one does not explain all of my problem.
1. the corrupted inode was still in the parent directory. It is
strange because unlink removes the directory entry first and then
iput deletes the inode.

2. some time, i_nlink was 0 and i_dtime was set which is I think
somewhat related with this patch, but the other time,
part of a inode block was cleaned with 0, which I do not understand
how at all.

Thank you,
Yoshi
-- 
--
Yoshihiro Tsuchiya


