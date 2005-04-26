Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVDZAXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVDZAXY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 20:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVDZAXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 20:23:24 -0400
Received: from groover.houseafrikarecords.com ([12.162.17.52]:63059 "EHLO
	Mansi.STRATNET.NET") by vger.kernel.org with ESMTP id S261210AbVDZAXV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 20:23:21 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: timur.tabi@ammasso.com, hch@infradead.org, hozer@hozed.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
X-Message-Flag: Warning: May contain useful information
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>
	<20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com>
	<20050411163342.GE26127@kalmia.hozed.org> <5264yt1cbu.fsf@topspin.com>
	<20050411180107.GF26127@kalmia.hozed.org> <52oeclyyw3.fsf@topspin.com>
	<20050411171347.7e05859f.akpm@osdl.org> <4263DEC5.5080909@ammasso.com>
	<20050418164316.GA27697@infradead.org> <4263E445.8000605@ammasso.com>
	<20050423194421.4f0d6612.akpm@osdl.org> <426BABF4.3050205@ammasso.com>
	<52is2bvvz5.fsf@topspin.com> <20050425135401.65376ce0.akpm@osdl.org>
	<521x8yv9vb.fsf@topspin.com> <20050425151459.1f5fb378.akpm@osdl.org>
	<426D6D68.6040504@ammasso.com> <20050425153256.3850ee0a.akpm@osdl.org>
	<52vf6atnn8.fsf@topspin.com> <20050425171145.2f0fd7f8.akpm@osdl.org>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 25 Apr 2005 17:23:17 -0700
In-Reply-To: <20050425171145.2f0fd7f8.akpm@osdl.org> (Andrew Morton's
 message of "Mon, 25 Apr 2005 17:11:45 -0700")
Message-ID: <52acnmtmh6.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 26 Apr 2005 00:23:17.0772 (UTC) FILETIME=[24C6D4C0:01C549F6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> How does the driver detect process exit?

I already answered earlier but just to be clear: registration goes
through a character device, and all regions are cleaned up in the
->release() of that device.

I don't currently have any code accounting against RLIMIT_MEMLOCK or
testing CAP_FOO, but I have no problem adding whatever is thought
appropriate.  Userspace also has control over the permissions and
owner/group of the /dev node.

 - R.
