Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWDDMEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWDDMEK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 08:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWDDMEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 08:04:10 -0400
Received: from nproxy.gmail.com ([64.233.182.187]:12192 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932376AbWDDMEI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 08:04:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mmzdaa+CDa+C6CD0hlcKpeEKRVCp9jg0t3AQTlTGOKW1aNEuQeOZGjRC8MO5k2wvdC4Md+aq9mJUGzCg+ffvVI8Zo0o6FDAr8Tuts0eRHiq2IOG6Hp9p2kWNhjMgWtUdJAJaMY6rrYZpV2wK3RLHlszgrYNdCwVp0nM6xFMNRQI=
Message-ID: <6051e9370604040504g10fa1ab6k1500f36667b19c14@mail.gmail.com>
Date: Tue, 4 Apr 2006 17:34:07 +0530
From: "Priyanka Sharma" <sharmapriyanka5@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: getting problem in /proc/kcore
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

i m studying linux-kernel-2.6.16.

i m trying to understand basically how /proc/kcore works. for tht i hv
written a small c code & i hv added printk statments in open_kcore() ,
kclist_add(), get_kcore_size() and in read_kcore() in /proc/kcore.c
file...but after executing my c program it's not printing all printk
statments... after execution it is printing only statment tht i hv
written in kclist_add() function.

please any one can tell why it's not printing all statments in printk???

this the c program tht i hv written for reading /proc/kcore:

#include <stdio.h>

int main()
{
        FILE *fp;
        char array[10];
        int i=0;
        fp = fopen("/proc/kcore","r");
        if(!fp)
                return 1;
        while(i<10)
        {
                fgets(array,10,fp);
                printf("%s",array);
                i++;
        }
        fclose(fp);
        return 0;
}

thanks,
Priyanka
