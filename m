Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135650AbRDSMom>; Thu, 19 Apr 2001 08:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135648AbRDSMoc>; Thu, 19 Apr 2001 08:44:32 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:49937 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S135647AbRDSMoX> convert rfc822-to-8bit; Thu, 19 Apr 2001 08:44:23 -0400
From: s-jaschke@t-online.de (Stefan Jaschke)
Reply-To: stefan@jaschke-net.de
Organization: jaschke-net.de
To: Jens Axboe <axboe@suse.de>
Subject: Re: Problems with Toshiba SD-W2002 DVD-RAM drive (IDE)
Date: Thu, 19 Apr 2001 14:44:07 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01041714250400.01376@antares> <01041914131100.01232@antares> <20010419141538.S16822@suse.de>
In-Reply-To: <20010419141538.S16822@suse.de>
MIME-Version: 1.0
Message-Id: <01041914440701.01232@antares>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 April 2001 14:15, Jens Axboe wrote:
> This is really strange, are you sure your drive is ok? Does mounting
> dvd-rom and cd-rom's work fine?

OK. I'll check again with 2.4.4-pre4+patches:
(1) Mounting the SuSE DVD-ROM (-t iso9660) from /dev/hdc on /dvd and 
    reading from /dvd works. Same for CD-ROMs. I don't have a formatted
    DVD-RAM.
(2) Reading with "dd if=/dev/hdc ..." 
   (2.1) works with CD-ROM inserted
   (2.2) fails with DVD-ROM inserted
   (2.3) fails with DVD-RAM inserted
(3) Writing with "dd of=/dev/hdc ..." works (with DVD-RAM inserted).
(4) "mke2fs -b 2048 /dev/hdc" fails (with DVD-RAM inserted).

As if the drive gives the driver wrong information (like size=0)?

If nothing helps, I have to plug the drive into a Windows machine
to make sure it really works with Toshiba's own drivers. This would
be a major hassle, though. No place for Windows on my own machine.
Hence some amount of screwing... :-(


-- 
Stefan R. Jaschke <stefan@jaschke-net.de>
http://www.jaschke-net.de
