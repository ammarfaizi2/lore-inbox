Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261385AbREQJwr>; Thu, 17 May 2001 05:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261386AbREQJwh>; Thu, 17 May 2001 05:52:37 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:21697 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S261385AbREQJwc>;
	Thu, 17 May 2001 05:52:32 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15107.40572.438895.503360@harpo.it.uu.se>
Date: Thu, 17 May 2001 11:48:44 +0200
To: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: CPU overheat with 2.2
In-Reply-To: <Pine.LNX.4.31.0105170949430.29086-500000@phobos.fachschaften.tu-muenchen.de>
In-Reply-To: <Pine.LNX.4.31.0105170949430.29086-500000@phobos.fachschaften.tu-muenchen.de>
X-Mailer: VM 6.76 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Richter writes:
 > I just switched my brother's computer to a 2.2 kernel, and now the CPU
 > overheats under Linux after about half an hour (reproducible). It works
 > fine under Windows 95b and worked under Linux 2.0.38.
 > 
 > CPU is a Pentium 166 MMX on an Asus TX97 mainboard, ISA cards are a 3c509
 > and a Soundblaster.
 > ...
 > CONFIG_APM=y
 > CONFIG_APM_DO_ENABLE=y
 > CONFIG_APM_CPU_IDLE=y
 > CONFIG_APM_DISPLAY_BLANK=y

Try leaving CONFIG_APM_CPU_IDLE unset. I've learned the hard way that this
option doesn't do any good on many boards, and actually can _increase_ the
CPU temperature by preventing Linux' ordinary "hlt when idle" from triggering.
My ASUS P3B-F + PIII dropped 10+ degrees C when I unset CONFIG_APM_CPU_IDLE.
YMMW, of course.

/Mikael
