Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273896AbRIXNFG>; Mon, 24 Sep 2001 09:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273897AbRIXNE4>; Mon, 24 Sep 2001 09:04:56 -0400
Received: from t2.redhat.com ([199.183.24.243]:60923 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S273896AbRIXNEp>; Mon, 24 Sep 2001 09:04:45 -0400
Message-ID: <3BAF2F81.46678FC6@redhat.com>
Date: Mon, 24 Sep 2001 14:05:05 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christian =?iso-8859-1?Q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __alloc_pages: 0-order allocation failed
In-Reply-To: <20010924040208.A624@localhost.localdomain> <E15lVKr-0005cC-00@mrvdom00.schlund.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Bornträger wrote:
> 
> > I just installed 2.4.10, and...
> > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0126c2e
> 
> I saw the same message when running this c++ programm.
> 
> int main (int argc, char * argv[]) {
> char * test;
> while (1)
> test=new char[1024];
> }
> 
> My dmesg:
> 
> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c01219e7
> VM: killing process a.out

While this program is obviously "bad", it does show that something
is not right. It should print "OOM: killing process a.out" as the
kernel will have to deliberatly kill this "out of hand" program.
the "VM: killing" message means it could just as easily have killed
another program due to this DoS program...
