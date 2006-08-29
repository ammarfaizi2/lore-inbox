Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbWH2ODO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWH2ODO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 10:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWH2ODO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 10:03:14 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:2229 "EHLO gepetto.dc.ltu.se")
	by vger.kernel.org with ESMTP id S964977AbWH2ODM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 10:03:12 -0400
Message-ID: <44F44AB8.7090204@student.ltu.se>
Date: Tue, 29 Aug 2006 16:10:00 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Andrew Morton <akpm@osdl.org>, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Conversion to generic boolean
References: <44EFBEFA.2010707@student.ltu.se> <20060828093202.GC8980@infradead.org> <20060828171804.09c01846.akpm@osdl.org> <20060829114502.GD4076@infradead.org>
In-Reply-To: <20060829114502.GD4076@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Mon, Aug 28, 2006 at 05:18:04PM -0700, Andrew Morton wrote:
>  
>
>>At present we have >50 different definitions of TRUE and gawd knows how
>>many private implementations of various flavours of bool.
>>
>>In that context, Richard's approach of giving the kernel a single
>>implementation of bool/true/false and then converting things over to use it
>>makes sense.  The other approach would be to go through and nuke the lot,
>>convert them to open-coded 0/1.
>>
>>I'm not particularly fussed either way, really.  But the present situation
>>is nuts.
>>    
>>
>
>Let's start to kill all those utterly silly if (x == true) and if (x == false)
>into if (x) and if (!x) and pospone the type decision.
>
Ok, sounds like a good idea. But I think those who already use 
boolean-type can/should be changed. Just have to stop myself of 
converting "boolean" int's.

>                                                        Adding a bool type
>only makes sense if we have any kind of static typechecking that no one
>ever assign an invalid type to it.
>  
>
Do not agree on this thou. Of couse it is something to strive for, but 
_Bool is using the same boolean-logic as C always used:
0 is false, otherwise it is true
so blaming _Bool for using this seem a bit odd. Also, do you mean to 
approve changing the return-type of all the functions who returns a 
boolean but uses an integer?

