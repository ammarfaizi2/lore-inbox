Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269773AbUHZWiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269773AbUHZWiX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 18:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269753AbUHZWfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 18:35:24 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:14084 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S269685AbUHZWao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 18:30:44 -0400
From: Felipe Alfaro Solana <lkml@felipe-alfaro.com>
To: David Lang <david.lang@digitalinsight.com>
Subject: Re: silent semantic changes with reiser4
Date: Fri, 27 Aug 2004 00:30:19 +0200
User-Agent: KMail/1.7
Cc: Christophe Saout <christophe@saout.de>, Rik van Riel <riel@redhat.com>,
       Jamie Lokier <jamie@shareable.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
References: <Pine.LNX.4.44.0408261152340.27909-100000@chimarrao.boston.redhat.com> <1093536282.5482.6.camel@leto.cs.pocnet.net> <Pine.LNX.4.60.0408261348370.27825@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.60.0408261348370.27825@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408270030.20647.lkml@felipe-alfaro.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 August 2004 23:05, David Lang wrote:

> I also don't see why the VFS/Filesystem can't decide that (for example)
> this tar.gz is so active that instead of storing it as a tar.gz and
> providing a virtual directory of the contents that it instead stores the
> directory of the contents and makes the tar.gz virtual (regenerating it as
> needed or as extra system resources are available)

Because that would mean the kernel should "talk" the tar format, which is, 
IMHO, a Bad Idea (TM). Maybe the kernel could notify a user-space daemon to 
perform this task, instead.
