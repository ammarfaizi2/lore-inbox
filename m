Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271372AbRHOTZq>; Wed, 15 Aug 2001 15:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271380AbRHOTZg>; Wed, 15 Aug 2001 15:25:36 -0400
Received: from [195.66.192.167] ([195.66.192.167]:59407 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S271379AbRHOTZ1>; Wed, 15 Aug 2001 15:25:27 -0400
Date: Wed, 15 Aug 2001 22:28:01 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <1021327779.20010815222801@port.imtp.ilyichevsk.odessa.ua>
To: Joshua Schmidlkofer <menion@srci.iwpsd.org>
CC: linux-kernel@vger.kernel.org, samba@lists.samba.org
Subject: Re: smbfs mount failures
In-Reply-To: <01081512490000.01309@widmers.oce.srci.oce.int>
In-Reply-To: <563618943.20010815205612@port.imtp.ilyichevsk.odessa.ua>
 <01081512490000.01309@widmers.oce.srci.oce.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JS> What is the actual string you are using to mount?

smbmount //nt/e /mnt -o username=admin,password=secret
smbmount //nt/e /mnt -o username=admin,password=secret,ip=N.N.N.N

fails as described below.
Note! smbclient WORKS with these machine/username/pass!
I conclude it is a smbfs or smbmount problem, not a badly/unusually configured
NT or network problem. Also note that log messages are spewed by smbfs kernel
code.

Tried to mount to locally running Samba:

smbmount //linuxbox/in /mnt -o username=guest,password=

Works fine.

How I can help to investigate this problem?
Please CC me. I'm not on the list.

JS> On Wednesday 15 August 2001 11:56 am, VDA wrote:
>> I'm having trouble mounting SMB shares residing on a WinNT machine.
>> smbclient works fine, but after mounting the same share with the
>> same username,passwd etc with smbmount and trying to enter
>> newly mounted dir I see repeating msgs in the logs:
>>
>> ...
>> smb_catch_keepalive: already done                 [<- this is KERN_ERR!]
>> smb_retry: successful, new pid=PID, generation=N  [PID is the same, N grows
>> (N++)] smb_dont_catch_keepalive: server->data_ready == NULL
>> smb_trans2_request: result=-22, setting invalid
>> smb_close_socket: still catching keepalives!
>> smb_catch_keepalive: already done
>> smb_retry: successful, new pid=PID, generation=N+1
>> ...
>>
>> Since smbclient is working I presume it is a kernel smbfs bug or some
>> version mismatch between kernel and smbmount.
>>
>> smbmount: 2.2.0a
>> kernel: 2.4.5


