Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVGVMCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVGVMCK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 08:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVGVMCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 08:02:10 -0400
Received: from smtp-30.ig.com.br ([200.226.132.30]:37281 "EHLO
	smtp-30.ig.com.br") by vger.kernel.org with ESMTP id S261259AbVGVMCJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 08:02:09 -0400
To: bernd@firmix.at
From: Vinicius <jdob@ig.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: Kernel doesn't free Cached Memory
Date: Fri, 22 Jul 2005 09:02:05 -0300
X-Priority: 3 (Normal)
Message-ID: <20050722_120205_006490.jdob@ig.com.br>
X-Originating-IP: [10.17.1.76]172.31.47.254, 201.6.254.70
X-Mailer: iGMail [www.ig.com.br]
X-user: jdob@ig.com.br
Teste: asaes
MIME-Version: 1.0
Content-type: multipart/mixed;
	boundary="Message-Boundary-by-Mail-Sender-1122033724"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--Message-Boundary-by-Mail-Sender-1122033724
Content-type: text/plain; charset=ISO-8859-1
Content-description: Mail message body
Content-transfer-encoding: 8bit
Content-disposition: inline

On Fri, 2005-07-22 at 08:27 -0300, Vinicius wrote: 
[...] 
>>    I have a server with 2 Pentium 4 HT processors and 32 GB of >>RAM, 
this 
>> server runs lots of applications that consume lots of memory to. >>When I 
>>stop 
>> this applications, the kernel doesn't free memory (the  memory >>still in 
>>use) 
>> and the server cache lots of memory (~27GB). When I start this 
>>applications, 
>> the kernel sends  "Out of Memory" messages and kill some random 
>> applications. 
>> 
>>    Anyone know how can I reduce the kernel cached memory on RHEL >>3 
(kernel 
>> 2.4.21-32.ELsmp - Trial version)? There is a way to reduce the >>kernel 
>>cached 
>> memory utilization? 

>Probably RedHat's support can answer this for RHEL 3. 
> 
>	Bernd 
>-- 
> Firmix Software GmbH                   http://www.firmix.at/ 
>mobil: +43 664 4416156                 fax: +43 1 7890849-55 
>          Embedded Linux Development and Services 

Bernd, 

   The server runs RHEL Trial Version, without support... for tests purpose. 

   When I compile and run the following tester program: 

#include <stdio.h> 
#include <string.h> 
#include <stdlib.h> 

int main (void) { 
        int n = 0; 
        char *p; 

        while (1) { 
                if ((p = malloc(1<<20)) == NULL) { 
                        printf("malloc failure after %d MiB\n", n); 
                        return 0; 
                } 
                memset (p, 0, (1<<20)); 
                printf ("got %d MiB\n", ++n); 
        } 
} 

   The server alocates lots of free memory (including swap) to the tester 
program and when its finish, lots of cached memory are freed. 

   Have someone an idea why it's happens? Or how can I force the kernel to 
frees cached memory? 

Thanks again (sorry my bad eglish again!) 

Vinicius. 
Protolink Consultoria. 

--Message-Boundary-by-Mail-Sender-1122033724--

