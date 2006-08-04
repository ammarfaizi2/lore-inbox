Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWHDAPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWHDAPJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 20:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWHDAPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 20:15:08 -0400
Received: from mms2.broadcom.com ([216.31.210.18]:47112 "EHLO
	mms2.broadcom.com") by vger.kernel.org with ESMTP id S932350AbWHDAPG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 20:15:06 -0400
X-Server-Uuid: D9EB6F12-1469-4C1C-87A2-5E4C0D6F9D06
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
From: "Michael Chan" <mchan@broadcom.com>
To: "David Miller" <davem@davemloft.net>
cc: herbert@gondor.apana.org.au, tytso@mit.edu, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20060803.170143.20633018.davem@davemloft.net>
References: <20060803235326.GC7894@thunk.org>
 <20060803.165654.45876296.davem@davemloft.net>
 <20060803235927.GB10932@gondor.apana.org.au>
 <20060803.170143.20633018.davem@davemloft.net>
Date: Thu, 03 Aug 2006 17:16:40 -0700
Message-ID: <1154650600.3117.36.camel@rh4>
MIME-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3)
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006080309; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413031303230312E34344432393130332E303031352D422D2F342B574C684A754433704B705975633943514C71513D3D;
 ENG=IBF; TS=20060804001453; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006080309_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 68CC4EF10X81035239-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-03 at 17:01 -0700, David Miller wrote:
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Date: Fri, 4 Aug 2006 09:59:27 +1000
> 
> > Watchdogs usually require one heartbeat every 30 seconds or so.  Does
> > the ASF heartbeat need to be that frequent?
> 
> The ASF heartbeat needs to be sent every 2 seconds.
> 

Yep, we send it every 2 seconds and it will reset in 5 seconds after the
last heartbeat.  So the margin is 3 seconds.  These numbers are somewhat
arbitrary and the goal is to allow ASF to function properly without too
much delay after the system has crashed.

