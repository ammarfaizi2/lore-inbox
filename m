Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129994AbRBSAru>; Sun, 18 Feb 2001 19:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130261AbRBSArb>; Sun, 18 Feb 2001 19:47:31 -0500
Received: from snowstorm.mail.pipex.net ([158.43.192.97]:28803 "HELO
	snowstorm.mail.pipex.net") by vger.kernel.org with SMTP
	id <S129994AbRBSArT>; Sun, 18 Feb 2001 19:47:19 -0500
To: linux-kernel@vger.kernel.org
From: Trevor-Hemsley@dial.pipex.com (Trevor Hemsley)
Date: Mon, 19 Feb 2001 00:40:31
Subject: Re: Proliant hangs with 2.4 but works with 2.2.
X-Mailer: ProNews/2 V1.51.ib103
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20010219004729Z129994-513+7797@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Feb 2001 23:09:17, "lafanga lafanga" <lafanga1@hotmail.com>
wrote:

> I have a Compaq Proliant 1600 server which can be hung on demand with all 
> the 2.4 series kernels I have tried (2.4, 2.4.1 & 2.4.2-pre3). Kernel 2.2.16 
> runs perfectly (from a default RH7.0).
> 
> I have ensured that the server meets the necessary requirements for the 2.4 
> kernels (modutils etc) and I have tried kgcc and various gcc versions. When 
> compiling I have tried default configs and also minimalist configs (with 
> only cpqarray and tlan). I have also ensured that I have the latest current 
> SmartStart CD (4.9) and have setup the firmware for installing Linux.

If you cat /proc/ioports does cpqarray show any registered ioports? I 
think it has a bug that means it doesn't request_region() for the 
ioports it uses and this means that any other driver that tries to 
auto-detect hardware by probing ports can stomp on its toes. This is 
certainly the case for EISA cpqarray controllers which is where I 
found this. I sent a report into arrays@compaq.com or whatever the 
address listed in the maintainers file is but haven't heard anything. 
This bug _may_ only exist for EISA controllers - I couldn't test the 
PCI version since the only machine I have with one in is running that 
other o/s.

-- 
Trevor Hemsley, Brighton, UK.
Trevor-Hemsley@dial.pipex.com
