Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbVHIK6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbVHIK6e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 06:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbVHIK6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 06:58:34 -0400
Received: from kalyani.insilicasemi.com ([203.145.179.171]:3228 "EHLO
	kalyani.insilicasemi.com") by vger.kernel.org with ESMTP
	id S932511AbVHIK6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 06:58:34 -0400
From: "Sudheer" <rsud@insilica.com>
To: "'raja'" <vnagaraju@effigent.net>, <linux-kernel@vger.kernel.org>
Subject: RE: query...
Date: Tue, 9 Aug 2005 16:28:13 +0530
Message-ID: <025101c59cd1$412419b0$2f08a8c0@varuna>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <42F8855E.7070306@effigent.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First -> you hit the wrong ML
Second -> The message queue exists and the permissions specified by
oflag are denied, or the message queue does not exist and permission to
create the message queue is denied


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of raja
Sent: Tuesday, August 09, 2005 3:59 PM
To: linux-kernel@vger.kernel.org
Subject: query...

   Hi,
      I am Creating a posix message queue using the following code.


#include <stdio.h>
#include <stdlib.h>
#include <mqueue.h>
#include <errno.h>
#include <string.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>

int main(int argc,char *argv[])
{
    mqd_t mq_des;
    mq_des = mq_open(argv[1],O_CREAT | O_RDWR | O_EXCL,S_IRUSR | S_IWUSR

| S_IRGRP | S_IROTH , NULL);
    if(mq_des < 0)
    {
        printf("Unable To Create MsgQ\n");
        perror("mq_open");
        return mq_des;
    }
    printf("MsgQ is Opened With Descriptor : %d\n",mq_des);
    return mq_des;
}


and I after compiling I am giving

./a.out /root/Desktop/msgq1


But It is giving as unable to create message queue and showing error as
'permission denied'

Would you please help me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


