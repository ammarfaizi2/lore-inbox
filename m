Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161319AbWG1Vv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161319AbWG1Vv3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 17:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161320AbWG1Vv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 17:51:29 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:27069 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161319AbWG1Vv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 17:51:28 -0400
Date: Sat, 29 Jul 2006 07:50:54 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: ProfiHost - Stefan Priebe <s.priebe@profihost.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: XFS / Quota Bug in  2.6.17.x and 2.6.18x
Message-ID: <20060729075054.B2222647@wobbly.melbourne.sgi.com>
References: <44C8A5F1.7060604@profihost.com> <Pine.LNX.4.61.0607281909080.4972@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.61.0607281909080.4972@yvahk01.tjqt.qr>; from jengelh@linux01.gwdg.de on Fri, Jul 28, 2006 at 07:11:31PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 07:11:31PM +0200, Jan Engelhardt wrote:
> 
> > The crash only occurs if you use quota and IDE without barrier support.
> 
> I don't quite get this. I do use quota, and have barriers turned 
> off (either explicitly or because the drive does not support it),
> but yet no error message like you posted. Do I just have luck?

Heh, no - its more likely you just haven't needed to do a quotacheck
on a filesystem thats initially mounted readonly (like root often is).
I'm guessing you had quota enabled from earlier barrier-unaware kernels
and quotacheck only needs to be run during that initial mount.

cheers.

-- 
Nathan
