Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263700AbTKFQaY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 11:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263703AbTKFQaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 11:30:23 -0500
Received: from adsl-64-175-243-181.dsl.sntc01.pacbell.net ([64.175.243.181]:3614
	"EHLO top.worldcontrol.com") by vger.kernel.org with ESMTP
	id S263700AbTKFQaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 11:30:20 -0500
From: brian@worldcontrol.com
Date: Thu, 6 Nov 2003 08:43:59 -0800
To: linux-kernel@vger.kernel.org
Subject: Re: C3 compiled 2.4.20 kernel blows up on EPIA M (summary)
Message-ID: <20031106164359.GA3069@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
References: <20031102072323.GA7910@top.worldcontrol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031102072323.GA7910@top.worldcontrol.com>
X-No-Archive: yes
X-Noarchive: yes
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 01, 2003 at 11:23:23PM -0800, brian@worldcontrol.com wrote:
> I have a VIA EPIA M10000 motherboard.
> http://www.viavpsd.com/product/epia_m_spec.jsp?motherboardId=81
> 
> A 2.4.20 gentoo-sources kernel compiled with
> CONFIG_MCYRIXIII blows up during boot.  Basically just after
> hitting return on grub the screen turns to all blue 'V's and
> then the acts like someone pushed the reset button.
> 386 and 586 kernels work fine.
> I'm running gcc 3.2.3

I always like to follow up my own postings with a summary of the
results for future searches.

The VIA EPIA M10000 does not have a C3 processor on it so far
as release 2.4.20 of the kernel is concerned.  It has a C3-2
processor which apparently has a somewhat different instructions
set.  So use '-march=i686 -mmmx -msse' for gcc, and 
'Pentium II/Celeron' for the kernel.

-- 
Brian Litzinger
