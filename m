Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130148AbQKUMDJ>; Tue, 21 Nov 2000 07:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130177AbQKUMC7>; Tue, 21 Nov 2000 07:02:59 -0500
Received: from [203.200.144.37] ([203.200.144.37]:22789 "HELO
	nest.stpt.soft.net") by vger.kernel.org with SMTP
	id <S130148AbQKUMCq>; Tue, 21 Nov 2000 07:02:46 -0500
Organization: NeST India
Message-ID: <F6E1228667B6D411BAAA00306E00F2A520CF60@pdc2.nestec.net>
From: MOHAMMED AZAD <mohammedazad@nestec.net>
To: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Asynchronous processing...
Date: Tue, 21 Nov 2000 17:02:05 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am working on a crypto driver on linux kernel 2.2.14.. Currently my app
provides data to the driver and the driver process the data (say encrypt)
and gives it back to the app... This is a synchronous transfer mode.. But i
want to do this in an asynchronous manner.... ie user app supplies data and
the function supplying the data returns.. say after processing the data..
the driver informs the user app by some mechanism that the data is processed
and now the user app may get back the result....

These are the possible ways i think i can proceed.. 

One way is to signal the app say from my bottom half that the packet
processing is over... and now u can take the data... for this i will have to
maintain a shared memory of some sort right...???.. 

or

After getting the signal in the signal handler the user app sends another
request to get the data from the driver.. right??.. now i can copy the
result back to the user memory using copy_to_user.... 

which one of the methods is best???... or is there any other way to do this
kind of async transfer.?????... 
I think implemnting the shared memory and managing it will be more complex
than the later one.... 

And this driver i am working on needs high throughput for packet
processing... and thus i would like to avoid copying data to and fro from
user memory and all... 

Or for avoiding copying should i use mmap and all.... pls guide me on
this... 

or is there any mechanism by which i can send data also while issuing
signals....

any pointers in this area is very much appreciated....

thank u all

azad
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
