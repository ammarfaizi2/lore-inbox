Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263149AbTCNAc2>; Thu, 13 Mar 2003 19:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263162AbTCNAc2>; Thu, 13 Mar 2003 19:32:28 -0500
Received: from holomorphy.com ([66.224.33.161]:10184 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263149AbTCNAc0>;
	Thu, 13 Mar 2003 19:32:26 -0500
Date: Thu, 13 Mar 2003 16:42:56 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Gregory K. Ruiz-Ade" <gregory@castandcrew.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 instability on bigmem systems?
Message-ID: <20030314004256.GI20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Gregory K. Ruiz-Ade" <gregory@castandcrew.com>,
	linux-kernel@vger.kernel.org
References: <200303131627.22572.gregory@castandcrew.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303131627.22572.gregory@castandcrew.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13, 2003 at 04:27:22PM -0800, Gregory K. Ruiz-Ade wrote:
> The primary problem:  Whenever any process (or set of processes) initiates 
> intensive disk I/O, the system grinds to a halt, kswapd and kupdated 
> consume upwards of 40% to 60% CPU each, and system load averages can jump 
> upwards of 21.00.  The problem can be replicated with a simple find command 
> ("find / -print" seems to do it nicely).
> I have had two rather painful nights dealing with this (Monday and Tuesday 
> nights).  Luckily, I have a serial null-modem cable rigged up between the 
> troubled server and another server, and was able to capture all the info 
> from the Magic Sysrq commands that I could.
> Full details are at http://castandcrew.com/~gregory/lkmlstuff/burpr/2.4.20

Hmm, slabinfo would be very helpful, as well as meminfo.


On Thu, Mar 13, 2003 at 04:27:22PM -0800, Gregory K. Ruiz-Ade wrote:
> I've included the kernel config, the kernel and initrd images, the system 
> map file, output from "ps auxfww" and a couple screen scrapings from top, 
> and captures from magic sysrq commands from both crashes.
> I had problems like this with 2.4.19, and was directed to apply a patch to 
> inode.c, which appears to be part of a patch set for 2.4.19pre9aa2.  I've 
> archived it at:
> http://castandcrew.com/~gregory/lkmlstuff/burpr/2.4.19/patches/10_inode-highmem-2
> For 2.4.19, this solves _most_ of the stability issues, but I still have to 
> work with the LVM people and possibly whomever is responsible for the VM in 
> 2.4.19/2.4.20 to track down some kernel oopses (possibly a seperate 
> problem.)
> I will happily provide whatever other information is needed, though my 
> opportunities to test things on the machine in question is limited by the 
> fact that it's a production server.

You might need bh stuff (memclass-related or something like it) if it's
general disk io. Can't be too sure until slabinfo + meminfo materialize.


-- wli
