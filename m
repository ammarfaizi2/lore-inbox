Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270691AbTHJVR7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 17:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270692AbTHJVR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 17:17:59 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:44818 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S270691AbTHJVRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 17:17:54 -0400
Date: Sun, 10 Aug 2003 23:17:45 +0200
To: gaxt <gaxt@rogers.com>,
       Henrik =?iso-8859-15?Q?R=E6der?= Clausen <henrik@fangorn.dk>,
       Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       "Mr. James W. Laferriere" <babydr@baby-dragons.com>,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: 2.6.0-test3 cannot mount root fs
Message-ID: <20030810211745.GA5327@gamma.logic.tuwien.ac.at>
References: <20030809104024.GA12316@gamma.logic.tuwien.ac.at> <1060436885.467.0.camel@teapot.felipe-alfaro.com> <3F34D0EA.8040006@rogers.com> <20030809104024.GA12316@gamma.logic.tuwien.ac.at> <20030809115656.GC27013@www.13thfloor.at> <20030809090718.GA10360@gamma.logic.tuwien.ac.at> <20030809130641.A8174@electric-eye.fr.zoreil.com> <20030809090718.GA10360@gamma.logic.tuwien.ac.at> <01a201c35e65$0536ef60$ee52a450@theoden> <3F34D0EA.8040006@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE009FC23@hdsmsx402.hd.intel.com> <002e01c35e87$14c1ffc0$ee52a450@theoden> <3F3509C0.9050403@rogers.com> <Pine.LNX.4.56.0308091036190.16795@filesrv1.baby-dragons.com> <Pine.LNX.4.56.0308091030590.16795@filesrv1.baby-dragons.com> <1060436885.467.0.camel@teapot.felipe-alfaro.com> <20030809115656.GC27013@www.13thfloor.at> <20030809130641.A8174@electric-eye.fr.zoreil.com> <01a201c35e65$0536ef60$ee52a450@theoden> <3F34D0EA.8040006@rogers.com>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to all of you for the several suggestions, but none was
successfull till now:

I tried as boot cmd line:
	s root=03:41 acpi=off
and still it didn't work. Same problem.

And I am not using devfs.

My lilo looks like this:
boot = /dev/hda2
install = /boot/boot-bmp.b
bitmap = /boot/debian-bootscreen-woody.bmp
bmp-colors=1,,0,2,,0
bmp-table=120p,173p,1,15,17
bmp-timer=254p,432p,1,0,0
read-only
prompt
timeout=100
password=""
  mandatory
vga=0x317
...
image=/boot/vmlinuz-2.6.0-test3
        label=2.6.0-test3
        append="amd_disconnect=yes"
        read-only
        restricted

Where amd_disconnect a patch is which sets a bit in the pci register to
allow the athlon to disconnect during idle, which greatly decreases my
cpu/mobo temperature. But this is not done till the place were the root
fs should have been loaded.


Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
CLUN (n.)
A leg which has gone to sleep and has to be hauled around after you.
			--- Douglas Adams, The Meaning of Liff
