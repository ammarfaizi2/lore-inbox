Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264962AbSLSPM1>; Thu, 19 Dec 2002 10:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265012AbSLSPM1>; Thu, 19 Dec 2002 10:12:27 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:45903 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S264962AbSLSPM0>; Thu, 19 Dec 2002 10:12:26 -0500
Date: Thu, 19 Dec 2002 16:20:42 +0100 (CET)
From: bart@etpmod.phys.tue.nl
Reply-To: bart@etpmod.phys.tue.nl
Subject: Re: Intel P6 vs P7 system call performance
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org, billyrose@billyrose.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Message-Id: <20021219152044.7846F51FC4@gum12.etpnet.phys.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Dec, Richard B. Johnson wrote:
> On Thu, 19 Dec 2002 billyrose@billyrose.net wrote:

>> long_call:
>>         pushl $0xfffff000
>>         ret
>> 
> 
> Because the number pushed onto the stack is a displacement, not
> an address, i.e., -4095. To have the address act as an address,

Not true. A ret(urn) is (sort of) equivalent to 'pop %eip'. The above
code would actually jump to address 0xfffff000, but probably be slow
since it confuses the branch prediction.

Bart

-- 
Bart Hartgers - TUE Eindhoven 
http://plasimo.phys.tue.nl/bart/contact.html
