Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269242AbUI3PZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269242AbUI3PZs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 11:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269260AbUI3PZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 11:25:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17875 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269242AbUI3PZq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 11:25:46 -0400
Date: Thu, 30 Sep 2004 16:25:44 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Borislav Petkov <petkov@uni-muenster.de>
Cc: linux-kernel@vger.kernel.org, bbpetkov@yahoo.de
Subject: Re: [PATCH] 2.6.9-rc3 fix warnings in sound/drivers/opl3/opl3_lib.c
Message-ID: <20040930152544.GD23987@parcelfarce.linux.theplanet.co.uk>
References: <20040930122853.GA28332@none>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040930122853.GA28332@none>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 02:28:53PM +0200, Borislav Petkov wrote:
> Hi there,
>    I get these warnings while compiling 2.6.9-rc3:
>    sound/drivers/opl3/opl3_lib.c: In function `snd_opl3_cs4281_command':   
>    sound/drivers/opl3/opl3_lib.c:101: warning: passing arg 2 of `writel'  makes pointer from integer without a cast   
>    sound/drivers/opl3/opl3_lib.c:104: warning: passing arg 2 of `writel'  makes pointer from integer without a cast
>    
>    Hope this fix is correct.

It looks very odd.  At the very least we don't want to overload the
fields in question (->r_port and ->l_port) that way.
