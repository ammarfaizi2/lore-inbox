Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291195AbSBLVQd>; Tue, 12 Feb 2002 16:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291192AbSBLVQP>; Tue, 12 Feb 2002 16:16:15 -0500
Received: from mail.myrio.com ([63.109.146.2]:25594 "HELO mail.myrio.com")
	by vger.kernel.org with SMTP id <S291193AbSBLVPn> convert rfc822-to-8bit;
	Tue, 12 Feb 2002 16:15:43 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
Subject: RE: secure erasure of files?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Tue, 12 Feb 2002 13:14:14 -0800
Message-ID: <A015F722AB845E4B8458CBABDFFE63420FE3A9@mail0.myrio.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: secure erasure of files?
Thread-Index: AcGzyj6jIVUwhSuQRqONInSC2R8+3QAPhV6w
From: "Torrey Hoffman" <Torrey.Hoffman@myrio.com>
To: "Roy Sigurd Karlsbakk" <roy@karlsbakk.net>,
        "Denis Vlasenko" <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Feb 2002 21:15:09.0355 (UTC) FILETIME=[59DF17B0:01C1B40A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IIRC, last time this topic came up, the best answer was:

Given modern disk hardware (block remapping) and operating 
system behavior, no, there is no way to securely delete files 
regardless of OS or filesystem.  

(AFAIK, the transparent hardware block remapping cannot be
detected or worked around in software - any software - but 
perhaps the IDE experts here know otherwise. )

If you don't want a sufficiently determined attacker to be
able to read your data from the disk, don't write it.

The solution is to use encryption and make sure your data is 
never, ever written to disk unencrypted.  In particular, use 
encrypted swap and encrypted loopback filesystems.

Torrey

