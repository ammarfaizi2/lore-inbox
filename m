Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319727AbSIMRln>; Fri, 13 Sep 2002 13:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319729AbSIMRln>; Fri, 13 Sep 2002 13:41:43 -0400
Received: from tomts13-srv.bellnexxia.net ([209.226.175.34]:11923 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S319727AbSIMRlm>; Fri, 13 Sep 2002 13:41:42 -0400
Message-ID: <3D82247A.80601@googgun.com>
Date: Fri, 13 Sep 2002 13:46:34 -0400
From: Ahmed Masud <masud@googgun.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thunder from the hill <thunder@lightweight.ods.org>
CC: Andreas Steinmetz <ast@domdv.de>, Bob_Tracy <rct@gherkin.frus.com>,
       dag@brattli.net, linux-kernel@vger.kernel.org
Subject: Re: 2.5.34: IR __FUNCTION__ breakage
References: <Pine.LNX.4.44.0209131013080.10048-100000@hawkeye.luckynet.adm>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thunder from the hill wrote:

>Hi,
>
>On Fri, 13 Sep 2002, Andreas Steinmetz wrote:
>
>>At least for gcc 3.2 this would be better:
>>
>>#define DERROR(dbg, fmt, args...) \
>>     do { if (DEBUG_##dbg) \
>>         printk(KERN_INFO "irnet: %s(): " fmt, __FUNCTION__, ##args); \
>>     } while(0)
>>
Perhaps a hybrid of the two? :

#define DERROR(dbg, fmt, args...)                                          \
    do { if (DEBUG_##dbg) {                                                \
                printk(KERN_INFO "irnet: %s() : ", __FUNCTION__);          \
                printk(fmt, ## args);                                      \
         }                                                                 \
    } while (0)

