Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265290AbRF2CwO>; Thu, 28 Jun 2001 22:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265436AbRF2CwE>; Thu, 28 Jun 2001 22:52:04 -0400
Received: from ip-33-237-104-152.anlai.com ([152.104.237.33]:23567 "EHLO
	exchsh01.viatech.com.cn") by vger.kernel.org with ESMTP
	id <S265290AbRF2Cvw> convert rfc822-to-8bit; Thu, 28 Jun 2001 22:51:52 -0400
Message-ID: <61F2703C314FD5118C0300010250D52E0580C0@exchsh01.viatech.com.cn>
From: =?utf-8?B?RnJhbmsgWmh1IChTaGFuZ2hhaSk=?= <FrankZhu@viatech.com.cn>
To: =?utf-8?B?J0FsYW4gQ294Jw==?= <alan@lxorguk.ukuu.org.uk>, mikpe@csd.uu.se
Cc: bernds@redhat.com,
        =?utf-8?B?RnJhbmsgWmh1IChTaGFuZ2hhaSk=?= <FrankZhu@viatech.com.cn>,
        linux-kernel@vger.kernel.org, mikpe@csd.uu.se
Subject: =?utf-8?B?UkU6IFBST0JMRU06SWxsZWdhbCBpbnN0cnVjdGlvbiB3aGVuIG1v?=
	=?utf-8?B?dW50IG5mcyBmaWxlIHN5c3RlbXMgdXNpbmc=?=
Date: Fri, 29 Jun 2001 10:52:45 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok.
i just do another test.maybe meaningful.
1)no matter i select -march=i686 or -march=i386 the result are the same. 
2)the server 192.168.0.254 (netboot) ,client 192.168.0.3
there are /usr ,/usr/local/ ,/home, /lib, /bin ....... on the server
on the client
A: mount -t nfs netboot:/usr  /usr
    mount -t nfs netboot:/lib /lib
    mount -t nfs netboot:/bin /bin
    mount -t nfs netboot:/sbin /sbin
Illegal instruction (core dumped)

B:mount  -t nfs netboot:/usr /1
    mount -t nfs netboot:/lib /2
    mount -t nfs netboot:/bin /3
    mount -t nfs netboot:/sbin /4
    mount ...................
ok

it seems that mount on the  same mount point(/usr----/usr....) error occurs
but on the different mount point(/usr------/1......) seems ok
then i install a machine with (lower version distribution kernel
2.2.13)Bluepoint 1.0. there are no mount problems above.

  

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: 2001年6月29日 7:12
To: mikpe@csd.uu.se
Cc: alan@lxorguk.ukuu.org.uk; bernds@redhat.com; FrankZhu@viatech.com.cn;
linux-kernel@vger.kernel.org; mikpe@csd.uu.se
Subject: Re: PROBLEM:Illegal instruction when mount nfs file systems using


> Here I have to disagree with you Alan. When you pass "-march=i686" to
> gcc, you are _not_ saying "generate code for a CPUID family 6 CPU".
> "-march=i686" actually means "target an Intel P6 family chip, given
> what we currently know about them". The gcc info pages don't talk

Which is fine. The Pentium Pro manual explicitly states that cmov may go
away. So it is not based on what we know about the CPU, its based on not
reading the documentation. 

It's a bug. -march=i6868 does not 'target an Intel P6 family chip, ...'
It happens to work because the error in reading the docs was never triggered
by intel removing cmov from a cpu as the reserved the right to do

Alan
