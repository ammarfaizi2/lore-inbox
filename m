Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbVHIKfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbVHIKfo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 06:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbVHIKfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 06:35:44 -0400
Received: from effigent.net ([210.211.230.208]:33011 "EHLO effigent.net")
	by vger.kernel.org with ESMTP id S932507AbVHIKfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 06:35:44 -0400
Message-ID: <42F8855E.7070306@effigent.net>
Date: Tue, 09 Aug 2005 15:58:46 +0530
From: raja <vnagaraju@effigent.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: query...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
