Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262280AbVC2Gf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbVC2Gf5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 01:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbVC2GcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 01:32:23 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:3792 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262280AbVC2Gau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 01:30:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=EGNQIMtpHL5Oux2Y7SqNR1gfi2CiAigapl+AX9dGYr6GaBON7X3yOsDQeh5Zc9aY/+Eqdv1Gq03qEYIZWocgJpnP3k0Hv+Vttvq/6A9fuFMmkKuzMOm8pVGhbxLC92SPXWxp6vp/tCTb3Z34iznBcdvnzX0G8rJjA/vSdgM0j/Y=
Message-ID: <84144f02050328223017b17746@mail.gmail.com>
Date: Tue, 29 Mar 2005 09:30:44 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] no need to check for NULL before calling kfree() -fs/ext2/
Cc: Dave Jones <davej@redhat.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       penberg@cs.helsinki.fi
In-Reply-To: <1112064777.19014.17.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
	 <1111825958.6293.28.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
	 <Pine.LNX.4.62.0503270044350.3719@dragon.hyggekrogen.localhost>
	 <1111881955.957.11.camel@mindpipe>
	 <Pine.LNX.4.62.0503271246420.2443@dragon.hyggekrogen.localhost>
	 <20050327065655.6474d5d6.pj@engr.sgi.com>
	 <Pine.LNX.4.61.0503271708350.20909@yvahk01.tjqt.qr>
	 <20050327174026.GA708@redhat.com> <1112064777.19014.17.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2005 21:52:57 -0500, Lee Revell <rlrevell@joe-job.com> wrote:
> I see kfree used in several hot paths.  Check out
> this /proc/latency_trace excerpt:

Yes, but is the pointer being free'd NULL most of the time? The
optimization does not help if you are releasing actual memory.

                           Pekka
