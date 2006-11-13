Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753952AbWKMFb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952AbWKMFb7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 00:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753946AbWKMFb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 00:31:59 -0500
Received: from cantor.suse.de ([195.135.220.2]:58334 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1753952AbWKMFb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 00:31:58 -0500
From: Andi Kleen <ak@suse.de>
To: Zachary Amsden <zach@vmware.com>
Subject: Re: [Opps] Invalid opcode
Date: Mon, 13 Nov 2006 06:31:45 +0100
User-Agent: KMail/1.9.5
Cc: caglar@pardus.org.tr, linux-kernel@vger.kernel.org,
       Gerd Hoffmann <kraxel@suse.de>, john stultz <johnstul@us.ibm.com>
References: <200611051507.37196.caglar@pardus.org.tr> <200611120439.56199.caglar@pardus.org.tr> <4557F287.7050807@vmware.com>
In-Reply-To: <4557F287.7050807@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200611130631.45682.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 November 2006 05:20, Zachary Amsden wrote:
> S.Çağlar Onur wrote:
> > 05 Kas 2006 Paz 18:40 tarihinde, Andi Kleen şunları yazmıştı: 
> >   
> >> And does it still happen in 2.6.19-rc4?
> >>     
> >
> > Sorry for delayed test result, i cannot reproduce this panic with 2.6.19-rc5
> >   
> 
> I would like to find the exact cause of the problem; 

It's all related to i386's abuse of the cpu hotplug state machine.
Eventually that needs to be fixed properly like it was on x86-64
(I didn't dare touch i386 back then because this code is so fragile on old
hardware) 

-Andi
