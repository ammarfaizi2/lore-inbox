Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbTKUCyr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 21:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264198AbTKUCyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 21:54:47 -0500
Received: from dci.doncaster.on.ca ([66.11.168.194]:17116 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S263464AbTKUCyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 21:54:46 -0500
From: Andrew Miklas <public@mikl.as>
Reply-To: public@mikl.as
To: benh@kernel.crashing.org, jgarzik@pobox.com
Subject: Re: Announce: ndiswrapper
Date: Thu, 20 Nov 2003 21:53:19 -0500
User-Agent: KMail/1.5
References: <TNwv.6Lz.7@gated-at.bofh.it> <TPHV.1vf.1@gated-at.bofh.it> <TQXu.420.11@gated-at.bofh.it>
In-Reply-To: <TQXu.420.11@gated-at.bofh.it>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200311202150.23184.public@mikl.as>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On November 20, 2003 02:00 am, Benjamin Herrenschmidt wrote:
> Still, I've looked into possibly reverse engineering the Broadcom
> one for 802.11g from MacOS X (with 2 machines kernel debugging and
> functions names embedded in the driver, it's not _that_ bad). But
> it's a +500k binary .... I didn't go very far and decided I had
> better ways to spend my time.
>

Just in case anyone here is interested, a few of us over at 
linux-bcom4301.sourceforge.net have been working (albeit slowly) at reverse 
engineering this driver.

Actually, one ongoing project is to get the Broadcom driver with ndiswrapper 
to run inside an emulator like bochs, so we can monitor all the IO.  
Actually, something I posted last week about doing DMA to userspace was for 
this project.

For reference, Linksys has provided the source code for the components of the 
Broadcom wireless driver that are statically linked with the kernels included 
in many of their new 802.11g wireless products [1].  However, there remains a 
component that we still have in binary-only form.

For the curious, the total size of the binary-only part is 386K of mipsel 
code.  We also have this module in it's unlinked form.

I've looked at a few functions to see how simple it would be to reverse 
engineer.  Some of it is pretty easy to follow.  However, there are parts 
that become very complicated, where they start doing branches on conditions 
like: "if it is a BCM4301 chip, integrated on a Dell board, where the core 
revision is less than ver. X then set some flag".  



-- Andrew


[1] http://www.linksys.com/support/opensourcecode/wap54g/wap54g.1.08.tar.gz
(Download the WAP54G package)
