Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161037AbVKQAPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161037AbVKQAPp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 19:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030581AbVKQAPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 19:15:45 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:6016 "EHLO
	vger.utah-nac.org") by vger.kernel.org with ESMTP id S1030576AbVKQAPo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 19:15:44 -0500
Message-ID: <437BB7D1.2090109@wolfmountaingroup.com>
Date: Wed, 16 Nov 2005 15:50:57 -0700
From: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: Adrian Bunk <bunk@stusta.de>, Andi Kleen <ak@suse.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Oliver Neukum <oliver@neukum.org>, jmerkey <jmerkey@utah-nac.org>,
       alex14641@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <20051116005034.73421.qmail@web50210.mail.yahoo.com> <200511161630.59588.oliver@neukum.org> <1132155482.2834.42.camel@laptopd505.fenrus.org> <200511161710.05526.ak@suse.de> <20051116184508.GP5735@stusta.de> <20051117000654.GA11128@wohnheim.fh-wedel.de>
In-Reply-To: <20051117000654.GA11128@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:

>On Wed, 16 November 2005 19:45:08 +0100, Adrian Bunk wrote:
>  
>
>>Jörn did some analysis regarding possible call paths > 3k.
>>    
>>
>
>And most of them have been changed since.  Zlib remains high on the
>list, but those paths are from /lib/inflate.c, during bootup.
>
>What remains to be analysed is the recursions.  If someone seriously
>wants to work on those, I can respin the tests.  The process is not
>fully automated, so it will take me a weekend (and this weekend is
>scheduled for a party).
>
>Jörn
>
>  
>
The SCSI layer needs to be checked.  I reproduced another crash on today 
on an older Niksun box running off the end of the stack.

Jeff

