Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266009AbUHMPqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUHMPqm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 11:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266005AbUHMPql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 11:46:41 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:5615 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S266034AbUHMPqg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 11:46:36 -0400
Date: Fri, 13 Aug 2004 17:45:22 +0200
From: Cornelia Huck <kernel@cornelia-huck.de>
To: johnpol@2ka.mipt.ru
Cc: Adrian Bunk <bunk@fs.tum.de>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let W1 select NET
Message-Id: <20040813174522.73221785@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <1092409800.12729.454.camel@uganda>
References: <20040813101717.GS13377@fs.tum.de>
	<Pine.LNX.4.58.0408131231480.20635@scrub.home>
	<20040813105412.GW13377@fs.tum.de>
	<20040813155233.04ccac4a@gondolin.boeblingen.de.ibm.com>
	<1092409800.12729.454.camel@uganda>
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2004 19:10:00 +0400
Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

> It is just not a good example.
> In other words - it is bad config dependencies.
> You just caught error.
> Not very good example with depends:
> 
> config A
> 	depends on B
> config B
> 	depends on C
> config C
> 	depends on A
> 
> Just do not create wrong dependencies - although it sounds like "do 
> not create deadlocks".

Hm, none too easy with configurations spread over multiple files :) - however, should select really be able to activate an option with unmet dependencies?

(and iirc, you are warned about circular dependencies?)

Regards,
Cornelia
