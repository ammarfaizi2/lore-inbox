Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUEHOLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUEHOLv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 10:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbUEHOLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 10:11:51 -0400
Received: from pxy7allmi.all.mi.charter.com ([24.247.15.58]:41369 "EHLO
	proxy7-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S262914AbUEHOLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 10:11:50 -0400
Message-ID: <409CEB4B.3070909@quark.didntduck.org>
Date: Sat, 08 May 2004 10:14:35 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040506
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: read lkml <read_lkml@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Question regarding switch_to on x86
References: <20040507194448.24330.qmail@web90006.mail.scd.yahoo.com>
In-Reply-To: <20040507194448.24330.qmail@web90006.mail.scd.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

read lkml wrote:
> Hi,
> 
> Could anyone please explain to me (or point me to some
> documentation) the need for the 3rd argument in the
> switch_to macro on x86? Why is it 
> switch_to(prev, next, last)? how are prev and last
> different? 
> 
> Thanks
> 

last is actually a return value.  Since switch_to() switches stacks, 
last must be passed through in a register.

--
				Brian Gerst
