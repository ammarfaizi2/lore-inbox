Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264610AbTGHQmR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 12:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264911AbTGHQmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 12:42:17 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:38317
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264610AbTGHQmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 12:42:15 -0400
Subject: Re: [PATCH] Fastwalk: reduce cacheline bouncing of d_count
	(Changelog@1.1024.1.11)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: herbert@13thfloor.at
Cc: trond.myklebust@fys.uio.no, Marcelo Tosatti <marcelo@conectiva.com.br>,
       hannal@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <20030708164426.GB10004@www.13thfloor.at>
References: <16138.53118.777914.828030@charged.uio.no>
	 <1057673804.4357.27.camel@dhcp22.swansea.linux.org.uk>
	 <16138.56467.342593.715679@charged.uio.no>
	 <1057677613.4358.33.camel@dhcp22.swansea.linux.org.uk>
	 <20030708164426.GB10004@www.13thfloor.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057683213.5228.3.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Jul 2003 17:53:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-08 at 17:44, Herbert Poetzl wrote:
> > Its no big problem to me since I can just back it out of -ac
> 
> just curious, because I use this patch since early 2.4.20,
> are there any reasons to 'back it out of -ac' for you?
> 
> anyway I totally agree that the NFS issue pointed out by 
> Trond should be addressed ...

Its high risk, its got bugs as Trond already showed and it only
helps performance on giant SMP boxes. Its all risk and no
reward. Quota updates get you working 32bit uid quota and
the interactivity stuff helps all even tho its got some
risk.


