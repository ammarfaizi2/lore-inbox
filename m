Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315179AbSEaHnt>; Fri, 31 May 2002 03:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315182AbSEaHns>; Fri, 31 May 2002 03:43:48 -0400
Received: from mailrelay.nefonline.de ([212.114.153.196]:32525 "EHLO
	mailrelay.nefonline.de") by vger.kernel.org with ESMTP
	id <S315179AbSEaHnr>; Fri, 31 May 2002 03:43:47 -0400
Message-Id: <200205310743.JAA28657@myway.myway.de>
From: "Daniela Engert" <dani@ngrt.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "system_lists@nullzone.org" <system_lists@nullzone.org>
Date: Fri, 31 May 2002 09:43:39 +0200 (CDT)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.20.2200 for OS/2 Warp 4.05
In-Reply-To: <5.1.0.14.2.20020530205439.02cb50e8@192.168.2.131>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: Halt on 2.5.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2002 20:57:04 +0200, system_lists@nullzone.org wrote:

>I got next message some hours ago on a kernel 2.5.18

>May 30 18:39:10 server01 kernel: hdc: dma_intr: status=0x7f { DriveReady 
>DeviceF
>ault SeekComplete DataRequest CorrectedError Index Error }
>May 30 18:39:10 server01 kernel: hdc: dma_intr: error=0x00 { }
>
>Any guru can tell me what this exactly mean?

The driver tried to read the disk's status register at the wrong
instant of time. Most likely, the host chip's dma engine was still
active, preventing access to the task file registers.

Ciao,
  Dani


