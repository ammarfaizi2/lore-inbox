Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271112AbRHXLQz>; Fri, 24 Aug 2001 07:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271153AbRHXLQp>; Fri, 24 Aug 2001 07:16:45 -0400
Received: from smtp8.xs4all.nl ([194.109.127.134]:61639 "EHLO smtp8.xs4all.nl")
	by vger.kernel.org with ESMTP id <S271112AbRHXLQa>;
	Fri, 24 Aug 2001 07:16:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Erick Staal <elstaal@xs4all.nl>
Reply-To: elstaal@xs4all.nl
To: Marko van Dooren <Marko.vanDooren@student.kuleuven.ac.be>,
        linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Using Philips CDD3610 cd-writer crashes my system with every 2.4 kernel
Date: Fri, 24 Aug 2001 13:21:33 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <200108241045.f7OAjZ220280@urc1.cc.kuleuven.ac.be>
In-Reply-To: <200108241045.f7OAjZ220280@urc1.cc.kuleuven.ac.be>
MIME-Version: 1.0
Message-Id: <01082413213300.00959@andromeda>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Basically I've encountered the same problem, but it went away after 2.4.6.

Machine: P II 300 Mhz, Adaptec 2940 SCSI adapter, 64 Mb memory, 1x Seagate 
ST34520W, 1x Seagate ST34520LW, 1x Philips CDD 3610, Toshiba XM-6201TA
OS: Redhat 7.1 with latest patches (except kernel)

Division over the buses as shown by cdrecord -scanbus

Scsibus0
           0.0.0           Seagate ST34520W
           0.2.0           Seagate ST34520LW
           0.5.0           Toshiba CD-ROM XM-6201TA
Scsibus1
           1.0.0           Philips CDD-3610 CD R/RW


and as stated everything fine after 2.4.6 (however 2.4.3-5 showed the same 
behaviour as your machine). The cd drive makes after 2.4.6 a strange churning 
sound when initializing cdrecord however. The cd's that were burned however 
were flawless (at least up to 2.4.9).
Further info: in the 2.4.3-2.4.5 kernels the devices which are above shown in 
scsibus0 were shown in scsibus1 and vice versa...

Sincerely, Erick
