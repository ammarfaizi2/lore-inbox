Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263057AbTCSOGT>; Wed, 19 Mar 2003 09:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263058AbTCSOGS>; Wed, 19 Mar 2003 09:06:18 -0500
Received: from eccentric.mae.cornell.edu ([128.253.249.157]:8455 "EHLO
	eccentric.mae.cornell.edu") by vger.kernel.org with ESMTP
	id <S263057AbTCSOGN>; Wed, 19 Mar 2003 09:06:13 -0500
Message-ID: <3E787F53.1000407@mae.cornell.edu>
Date: Wed, 19 Mar 2003 09:31:47 -0500
From: Andrey Klochko <andrey@mae.cornell.edu>
Reply-To: andrey@mae.cornell.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, ru
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH - for playing only] change type of dev_t
References: <UTC200303182213.h2IMDse09784.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:

>  * assume GCC is being used.
>  */
> 
>-typedef unsigned short	__kernel_dev_t;
>+typedef unsigned long	__kernel_dev_t;
>
Shouldn't this be
typedef unsigned int __kernel_dev_t;
according to

>@@ -70,13 +70,13 @@
>  * static arrays, and they are sized for a 8-bit index.
>  */
> typedef struct {
>-	unsigned short value;
>+	unsigned int value;
> } kdev_t;
> 
>
Andrey

-- 
-------------------------------------------------------------
Andrey Klochko
System Administrator
Sibley School of Mechanical and Aerospace Engineering
288 Grumman Hall
Cornell University
Ithaca, NY 14853


