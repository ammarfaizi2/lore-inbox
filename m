Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136097AbRD0QJU>; Fri, 27 Apr 2001 12:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136094AbRD0QJB>; Fri, 27 Apr 2001 12:09:01 -0400
Received: from tepid.osl.fast.no ([213.188.9.130]:14600 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S136091AbRD0QIt>; Fri, 27 Apr 2001 12:08:49 -0400
Message-ID: <3AE99989.EF69C2D5@fast.no>
Date: Fri, 27 Apr 2001 18:08:41 +0200
From: Michael =?iso-8859-1?Q?Sus=E6g?= <Michael.Susag@fast.no>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: O_DIRECT support in 2.4.4?
Content-Type: multipart/mixed;
 boundary="------------37B10C811ECF44E73C9F2F3A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------37B10C811ECF44E73C9F2F3A
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

We have tested the rawio and o_direct patches from Andrea Arcangeli 
with great success, and wondered if they will be part of the next 
kernel release, 2.4.4?

So far we have tested these patches on four different systems.
With the latest versions of these patches (rawio-6, o_direct-3) 
all systems works perfectly ok. Both with and without O_DIRECT 
enabled in big file operations.

The O_DIRECT support really helps performance a lot
for some types of applications. We happen to have such an 
application, and we would like to see O_DIRECT 
support in the kernel source in the near future.
 
This would lift Linux to a new level in terms of disk performance
for "self-caching" applications.

A performance test we did on our application shows a huge 
improvement, upto 8 times better data read speed with direct-IO.
With buffered IO, the CPU is doing caching most of the time.

I attached a graph showing this performance win using O_DIRECT
versus buffered IO. Each thread reads at a random offset a random 
amount of data from a big data set. The dataset is placed on 
a software RAID 0 with many disks. With that configuration 
we are able to fully utilize the 160 MB/s SCSI controllers.



-- 
Michael Susæg, M.Eng.             Mail:  Michael.Susag@fast.no
Software Engineer                 Web:   http://www.fast.no/
Fast Search & Transfer ASA        Phone: +47 21 60 12 27
P.O. Box 1677 Vika                Fax:   +47 21 60 12 01
NO-0120 Oslo, NORWAY

Try FAST Search: http://www.alltheweb.com/
--------------37B10C811ECF44E73C9F2F3A
Content-Type: image/png;
 name="directio.png"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="directio.png"

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
3EtaAAAAAElFTkSuQmCC
--------------37B10C811ECF44E73C9F2F3A--

