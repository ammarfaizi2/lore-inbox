Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271963AbRH2NUw>; Wed, 29 Aug 2001 09:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271964AbRH2NUm>; Wed, 29 Aug 2001 09:20:42 -0400
Received: from [195.66.192.167] ([195.66.192.167]:5639 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S271963AbRH2NUd>; Wed, 29 Aug 2001 09:20:33 -0400
Date: Wed, 29 Aug 2001 16:14:49 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <314590620.20010829161449@port.imtp.ilyichevsk.odessa.ua>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
CC: linux-kernel@vger.kernel.org
Subject: Re[2]: Shutting down NFS
In-Reply-To: <200108291258.HAA66579@tomcat.admin.navo.hpc.mil>
In-Reply-To: <200108291258.HAA66579@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jesse,

Wednesday, August 29, 2001, 3:58:07 PM, you wrote:
>> killall5 -15; sleep 5; killall5 -9; sleep 5
>> killall5 -15; sleep 5; killall5 -9; sleep 5
>> killall5 -15; sleep 5; killall5 -9 ?
>> 
>> This looks ugly and total sleep time is 25 sec.
>> A better way is to make NFS daemons understand what user wants after
>> first call, not a third.

JP> This already looks like overkill :-) Only the first one should be
JP> needed. I can understand that NFSD could disable signal 15, but not
JP> how it can disable 9... The only way I know for that to happen is
JP> if the process is in an uninterruptable sleep for some reason (and
JP> that should only delay signal delivery, not eliminate it).

It looks like killall5 bug - "killall -9 nfsd" kills nfsd at once.
Do you know where killall5 source is? There's no killall5 in
util-linux...

Best regards,
VDA
--
mailto:VDA@port.imtp.ilyichevsk.odessa.ua
http://port.imtp.ilyichevsk.odessa.ua/vda/


