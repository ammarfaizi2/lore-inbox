Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbVHIKkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbVHIKkk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 06:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbVHIKkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 06:40:40 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:7547 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932509AbVHIKkk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 06:40:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=puiSuO+6XJJjK79ATNtihbB27npKDXlkTqvULucHnbFB0jpqhl49+vs2cawGVEERg00PVzR/Jm1yMv7CeBCa3Fnq4FR2a0leWcT80WxqIw2c9G+wbs/Bs8mLfHv4+a4T/ZW0U/eK3NRRIoDOgqzZHOX0SrtIfndtqKFuBbacns0=
Message-ID: <17db6d3a05080903407418ed45@mail.gmail.com>
Date: Tue, 9 Aug 2005 16:10:37 +0530
From: Nikhil Dharashivkar <nikhildharashivkar@gmail.com>
To: raja <vnagaraju@effigent.net>
Subject: Re: query...
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42F8855E.7070306@effigent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42F8855E.7070306@effigent.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think it could be root permissions problem. Are you running this
binary as root user ?


On 8/9/05, raja <vnagaraju@effigent.net> wrote:
>    Hi,
>       I am Creating a posix message queue using the following code.
> 
> 
> #include <stdio.h>
> #include <stdlib.h>
> #include <mqueue.h>
> #include <errno.h>
> #include <string.h>
> #include <fcntl.h>
> #include <sys/stat.h>
> #include <sys/types.h>
> 
> int main(int argc,char *argv[])
> {
>     mqd_t mq_des;
>     mq_des = mq_open(argv[1],O_CREAT | O_RDWR | O_EXCL,S_IRUSR | S_IWUSR
> | S_IRGRP | S_IROTH , NULL);
>     if(mq_des < 0)
>     {
>         printf("Unable To Create MsgQ\n");
>         perror("mq_open");
>         return mq_des;
>     }
>     printf("MsgQ is Opened With Descriptor : %d\n",mq_des);
>     return mq_des;
> }
> 
> 
> and I after compiling I am giving
> 
> ./a.out /root/Desktop/msgq1
> 
> 
> But It is giving as unable to create message queue and showing error as
> 'permission denied'
> 
> Would you please help me.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Thanks and Regards,
         Nikhil.
