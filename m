Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261436AbSJYOcm>; Fri, 25 Oct 2002 10:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261437AbSJYOcm>; Fri, 25 Oct 2002 10:32:42 -0400
Received: from boden.synopsys.com ([204.176.20.19]:56022 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S261436AbSJYOck>; Fri, 25 Oct 2002 10:32:40 -0400
Date: Fri, 25 Oct 2002 16:38:44 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: patch: Linux 2.5.44-ac3, i386/config.in typo, "make xconfig" broken
Message-ID: <20021025143844.GF3512@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Alan Cox <alan@redhat.com>,
	linux-kernel@vger.kernel.org
References: <200210251019.g9PAJ8V14406@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210251019.g9PAJ8V14406@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 06:19:08AM -0400, Alan Cox wrote:
> ** I strongly recommend saying N to IDE TCQ options otherwise this
>    should hopefully build and run happily.
> 
>    Doug's scsi changes broke mptfusion. I've not looked into that yet
>    also u14f/u34f.
> 
>    This one builds, its not yet had any measurable testing

"make xconfig" for i386 produces:
  Generating scripts/kconfig.tk
-: 73: unknown command
wish -f scripts/kconfig.tk
Error in startup script: invalid command name "clear_choices"
    while executing
...

-alex

--- v2.5.44+bk-ac3/arch/i386/config.in	2002-10-25 16:32:43.000000000 +0200
+++ v2.5.44+bk-ac3/arch/i386/config.in	2002-10-25 16:28:16.000000000 +0200
@@ -70,7 +70,7 @@
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_PPRO_FENCE y
    define_bool CONFIG_X86_F00F_BUG y
-   define bool CONFIG_X86_PIT y
+   define_bool CONFIG_X86_PIT y
 fi
 if [ "$CONFIG_GEODE" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5


