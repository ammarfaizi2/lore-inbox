Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264801AbTFBRPm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 13:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264802AbTFBRPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 13:15:42 -0400
Received: from mx2.elte.hu ([157.181.151.9]:60360 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264801AbTFBRPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 13:15:37 -0400
Date: Mon, 2 Jun 2003 19:28:27 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Tom Sightler <ttsig@tuxyturvy.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@digeo.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Strange load issues with 2.5.69/70 in both -mm and -bk trees.
In-Reply-To: <1054567968.3545.26.camel@iso-8590-lx.zeusinc.com>
Message-ID: <Pine.LNX.4.44.0306021927170.10228-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2 Jun 2003, Tom Sightler wrote:

> I think this may be because wine uses a client/server model.  There is
> the wine client which runs the actual applications, but they seem to
> share the core wineserver process which seems to be responsible for
> actually mixing and generating the sound output.  Renicing the 'wine'
> (frontend) process give the 'wineserver' (backend) process more CPU time
> to actually get the sound out.

yes, this is an accurate description of the wineserver model. 

to prove this point, could you try and renice wineserver to -10 (as root) 
- does that fix the latency issues still?

(if this doesnt then it could be the foreground process starving yet
another process - we have to find out which one.)

	Ingo

