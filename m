Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264691AbUD1GAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264691AbUD1GAy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 02:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264692AbUD1GAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 02:00:54 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:18456 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264691AbUD1GAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 02:00:52 -0400
Date: Wed, 28 Apr 2004 16:00:03 +1000
From: Nathan Scott <nathans@sgi.com>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Dru <andru@treshna.com>,
       linux-xfs@oss.sgi.com, M?ns Rullg?rd <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: status of Linux on Alpha?
Message-ID: <20040428160003.C640934@wobbly.melbourne.sgi.com>
References: <yw1xr7vcn1z2.fsf@ford.guide> <20040329205233.5b7905aa@vaio.gigerstyle.ch> <20040404121032.7bb42b35@vaio.gigerstyle.ch> <20040409134534.67805dfd@vaio.gigerstyle.ch> <20040409134828.0e2984e5@vaio.gigerstyle.ch> <20040409230651.A727@den.park.msu.ru> <20040413194907.7ce8ceb7@vaio.gigerstyle.ch> <20040427185124.134073cd@vaio.gigerstyle.ch> <20040427215514.A651@den.park.msu.ru> <20040427200830.3f485a54@vaio.gigerstyle.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040427200830.3f485a54@vaio.gigerstyle.ch>; from gigerstyle@gmx.ch on Tue, Apr 27, 2004 at 08:08:30PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 08:08:30PM +0200, Marc Giger wrote:
> Hi Ivan,
> 
> Cool!
> 
> I will try your patch after I finished moving to my new flat:-)
> 
> I wonder why it happens only with the XFS code. What I saw
> rw_sem is used all over the place in the kernel.

We do use the downgrade_write interface in XFS, which has
an architecture specific component and a generic component.
Its much less widely used than the rest of the rw_semaphore
code - that'd be a good spot to look if one architecture is
behaving oddly.

cheers.

-- 
Nathan
