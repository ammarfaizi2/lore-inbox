Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271915AbRH2Gle>; Wed, 29 Aug 2001 02:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271916AbRH2GlY>; Wed, 29 Aug 2001 02:41:24 -0400
Received: from [195.66.192.167] ([195.66.192.167]:62729 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S271915AbRH2GlN>; Wed, 29 Aug 2001 02:41:13 -0400
Date: Wed, 29 Aug 2001 09:35:11 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <40933602.20010829093511@port.imtp.ilyichevsk.odessa.ua>
To: Jesse Pollard <jesse@cats-chateau.net>
CC: linux-kernel@vger.kernel.org
Subject: Shutting down NFS
In-Reply-To: <01082720543901.24861@tabby>
In-Reply-To: <200108260735.f7Q7ZH9k002632@leija.fmi.fi>
 <01082609324300.16138@tabby>
 <185011756.20010827095543@port.imtp.ilyichevsk.odessa.ua>
 <01082720543901.24861@tabby>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jesse,

Tuesday, August 28, 2001, 4:42:48 AM, you wrote:
JP> On Mon, 27 Aug 2001, VDA wrote:
>>...
>>  killall5 -15; sleep 2; killall5 -9:
>>    1st run - nothing
>>    2nd run - nfsd dies
>>    3rd run - lockd/statd die
>>    (This is strange. Complicates shutdown script)

JP> You are using 2 second delay, which might be a bit short, but not unreasonable.

I have tested this not by shutting down my system but by running a
test script, watching "ps -AH e" after each run.
After first run of "killall5 -15; sleep 2; killall5 -9" NFS daemons
DON'T die at all. After second run only nfsd dies. Only third run
kills lockd and statd. It does not matter how long I wait between
runs. (however I didn't wait for minutes. Do you want me to try it?)
Am I supposed to do the same in shutdown script, i.e.

killall5 -15; sleep 5; killall5 -9; sleep 5
killall5 -15; sleep 5; killall5 -9; sleep 5
killall5 -15; sleep 5; killall5 -9 ?

This looks ugly and total sleep time is 25 sec.
A better way is to make NFS daemons understand what user wants after
first call, not a third.
-- 
Best regards,
VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua
http://port.imtp.ilyichevsk.odessa.ua/vda/


