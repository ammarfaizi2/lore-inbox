Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285274AbRLNAVe>; Thu, 13 Dec 2001 19:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285276AbRLNAVY>; Thu, 13 Dec 2001 19:21:24 -0500
Received: from rcpt-expgw.biglobe.ne.jp ([210.147.6.214]:42955 "EHLO
	rcpt-expgw.biglobe.ne.jp") by vger.kernel.org with ESMTP
	id <S285274AbRLNAVN>; Thu, 13 Dec 2001 19:21:13 -0500
X-Biglobe-Sender: <k-suganuma@mvj.biglobe.ne.jp>
Date: Thu, 13 Dec 2001 16:20:26 -0800
From: Kimio Suganuma <k-suganuma@mvj.biglobe.ne.jp>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [ANNOUNCE] HotPlug CPU patch against 2.5.0
Cc: linux-kernel@vger.kernel.org, large-discuss@lists.sourceforge.net,
        Heiko Carstens <Heiko.Carstens@de.ibm.com>,
        Jason McMullan <jmcmullan@linuxcare.com>,
        Anton Blanchard <antonb@au1.ibm.com>,
        Greg Kroah-Hartman <ghartman@us.ibm.com>, rusty@rustcorp.com.au
In-Reply-To: <20011213224400.H8007@flint.arm.linux.org.uk>
In-Reply-To: <20011213132557.5B3E.K-SUGANUMA@mvj.biglobe.ne.jp> <20011213224400.H8007@flint.arm.linux.org.uk>
Message-Id: <20011213161734.5B4F.K-SUGANUMA@mvj.biglobe.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.00.05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 13 Dec 2001 22:44:00 +0000
Russell King <rmk@arm.linux.org.uk> wrote:

> On Thu, Dec 13, 2001 at 01:29:42PM -0800, Kimio Suganuma wrote:
> > Down CPU
> > echo 0 > /proc/sys/kernel/cpu/<id>/online
> > 
> > Up CPU
> > echo 1 > /proc/sys/kernel/cpu/<id>/online
> 
> Please use /proc/sys/cpu/*/ so that we have all CPU information in
> a consistent place.  Please see linux/include/linux/sysctl.h for the
> sysctl allocation.

I don't know much about sysctl specification, so could you show me
pointer to any document or something?

There is no /proc/sys/cpu directory on the latest kernel, and 
I guess someone is thinking the structure under the directory,
right?

I guess the operation would be

echo 1 > /proc/sys/cpu/hotplug/<cpu-id>/online
  or
echo 1 > /proc/sys/cpu/<cpu-id>/online
  or
echo <cpu-id> > /proc/sys/cpu/online

Which is the right way?

Regards,
Kimi

-- 
Kimio Suganuma <k-suganuma@mvj.biglobe.ne.jp>

