Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVA3Rpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVA3Rpx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 12:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVA3Rpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 12:45:53 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:33415 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S261747AbVA3Rps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 12:45:48 -0500
Date: Sun, 30 Jan 2005 18:45:47 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Subject: Non transparent Intel 82801 PCI Bridge fix in mainline kernel?
Message-ID: <20050130174547.GB3373@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after installing more RAM in my IBM Thinkpad G40 laptop, I ran into the 
problem that PCMCIA ceased to work.

The problem turned out to have been reported to this list in 2003:
http://www.ussg.iu.edu/hypermail/linux/kernel/0306.3/0956.html

For a 2.6 kernel the fix seems to be to either comment out 
pci_fixup_transparent_bridge in arch/i386/pci/fixup.c or to raise the 
value of pci_mem_start in arch/i386/kernel/setup.c.

However, none of these fixes have made it into mainline kernel (and I 
guess that is because they would break other platforms where the 
pci_fixup_transparent_bridge *is* needed). So lots of newer IBM 
Thinkpads with 1Gb RAM or more are unsupported with a vanilla kernel.

Now, the question is, is there any probability of a more specific 
fix being merged into the kernel and is there anyone with the code-fu to 
create such a patch?

Kind regards,
David Härdeman

Not subscribed...please CC me on any replies...
