Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263059AbUDTRe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbUDTRe6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 13:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUDTRe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 13:34:58 -0400
Received: from mail.mellanox.co.il ([194.90.237.34]:52283 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S263059AbUDTRe5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 13:34:57 -0400
Message-ID: <40855F95.7080003@mellanox.co.il>
Date: Tue, 20 Apr 2004 20:36:21 +0300
From: Eli Cohen <mlxk@mellanox.co.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: sysrq shows impossible call stack
References: <408545AA.6030807@mellanox.co.il> <52ekqizkd2.fsf@topspin.com>
In-Reply-To: <52ekqizkd2.fsf@topspin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:

>    Eli> Hi, I am exsperiencing a hang, probably caused by a deadlock,
>    Eli> so I can do sysrq commands. However I can see that in some
>    Eli> cases the exspected call stack has some functions in between
>    Eli> as if two call stack are interleaved.
>
>Hi Eli,
>
>I think what you are seeing is old values left on the stack.  If a
>function allocates space for local variables but bumping the stack
>pointer, but then never actually uses those variables, then old values
>including old return addresses may be left in the stack.
>
> - Roland
>  
>
Thanks Roland
