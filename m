Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbTJTKLu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 06:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbTJTKLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 06:11:49 -0400
Received: from codepoet.org ([166.70.99.138]:6097 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S262497AbTJTKLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 06:11:48 -0400
Date: Mon, 20 Oct 2003 04:11:47 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Juanjo =?iso-8859-1?Q?Garc=EDa_Carr=E9?= <juanjo@eurogaran.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Hangup with Radeon9200 accel. Does not happen when not using agpgart or disabling CPU internal cache.
Message-ID: <20031020101147.GA4904@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Juanjo =?iso-8859-1?Q?Garc=EDa_Carr=E9?= <juanjo@eurogaran.com>,
	linux-kernel@vger.kernel.org
References: <20031020100123.GA22114@eurogaran.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031020100123.GA22114@eurogaran.com>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Oct 20, 2003 at 12:01:23PM +0200, Juanjo García Carré wrote:
> 7) Make sure the agpgart module (and the intel_agp module for 2.6
> kernels) are loaded before launching XFree.
> 
> 8) Launch X. Everything seems to work; glxinfo says Yes as to direct
> rendering. Now launch an OpenGL application, like glxgears:
> It runs for some instants, then becomes blocked, as does the rest of the
> system.

I added this to my /etc/X11/XF86Config-4 to prevent my system
from locking solid as you describe.  This forces XFree86 to drive
my Radeon 9200 as if it were a Radeon 9000.  Before upgrading X,
I had to use 0x4242 to drive my card as a Radeon 8500.

Section "Device"
        Identifier      "ATI Radeon"
        Driver          "radeon"
        Option          "AGPMode"  "4"
        Option          "EnablePageflip"  "1"
        ChipID          0x4964
        #ChipID         0x4242
EndSection

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
