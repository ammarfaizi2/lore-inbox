Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbTIRKjg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 06:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbTIRKjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 06:39:36 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:61571 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S262108AbTIRKjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 06:39:35 -0400
Date: Thu, 18 Sep 2003 12:39:32 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Aki Tossavainen <cmouse@quakenet.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Unable to enable DMA mode on 2.4.22 (was able to do that before)
Message-ID: <20030918103932.GA8527@vana.vc.cvut.cz>
References: <Pine.LNX.4.53.0309181300380.16634@mordor.desteem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0309181300380.16634@mordor.desteem.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 18, 2003 at 01:06:59PM +0300, Aki Tossavainen wrote:
> I attemted to set DMA mode on with kernel 2.4.22 using
> hdparm -d 1 /dev/hda
> and I got:
> 
> /dev/hda:
>  setting using_dma to 1 (on)
>  HDIO_SET_DMA failed: Operation not permitted
>  using_dma    =  0 (off)
> 
> HDPARM version is 5.4
> 
> Before updating kernel I had no problems with this.
> 
> 00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
> (prog-if 8a [Master SecP PriP])

> # CONFIG_BLK_DEV_VIA82CXXX is not set

Hi Aki,
  what do you expect without enabling driver for your IDE chipset?
Enable it, and hdparm will work...

  You are supposed to run 'make oldconfig' after each kernel upgrade,
and answer all new questions it asks you... Otherwise you'll not
notice that IDE driver got split to the couple of chipset modules.
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz
