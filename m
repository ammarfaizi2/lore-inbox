Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267829AbUH3M2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267829AbUH3M2c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 08:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267830AbUH3M2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 08:28:32 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:32764 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S267829AbUH3M23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 08:28:29 -0400
Date: Mon, 30 Aug 2004 14:26:14 +0200
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Arthur Corliss <corliss@digitalmages.com>
Cc: Jay Lan <jlan@engr.sgi.com>, Tim Schmielau <tim@physik3.uni-rostock.de>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       erikj@dbear.engr.sgi.com, limin@engr.sgi.com,
       lse-tech@lists.sourceforge.net, ? <kernel@ragnark.vestdata.no>,
       Yoshitaka ISHIKAWA <y.ishikawa@soft.fujitsu.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: Re: [PATCH] new CSA patchset for 2.6.8
Message-ID: <20040830122614.GA2518@frec.bull.fr>
References: <412D2E10.8010406@engr.sgi.com> <20040825221842.72dd83a4.akpm@osdl.org> <Pine.LNX.4.53.0408261821090.14826@gockel.physik3.uni-rostock.de> <Pine.LNX.4.58.0408261111520.22750@bifrost.nevaeh-linux.org> <Pine.LNX.4.53.0408262133190.8515@broiler.physik3.uni-rostock.de> <412E4C27.1010805@engr.sgi.com> <Pine.LNX.4.58.0408271727020.1075@bifrost.nevaeh-linux.org>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.58.0408271727020.1075@bifrost.nevaeh-linux.org>
User-Agent: Mutt/1.5.6+20040722i
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/08/2004 14:31:37,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/08/2004 14:31:46,
	Serialize complete at 30/08/2004 14:31:46
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 05:27:19PM -0800, Arthur Corliss wrote:
> On Thu, 26 Aug 2004, Jay Lan wrote:
> 
> > I do like to see a common data collection method in the kernl. Kernel
> > does not need to decide how the data to be presented to the
> > user space. An accounting loadable module such as CSA or ELSA will
> > take care of how the data to be presented to meet the needs of
> > different users.
> >
> > Sounds reasonable?
> 
> Seconded.

  Thus, to be clear, the enhanced accounting can be divided into
three parts:

    1) A common data collection method in the kernel.
       We could start from BSD-accounting and add CSA information. Could
       it be something like BSD version4?

    2) A module that will manage a job history. I mean, it will manage a
       structure in which we will keep the relationship between processes and
       "containers" and also between process and its children. The
       property needed here is that a child belongs to the same "job"
       as its parent. This allows to do per-job accounting. I will have 
       a look to PAGG and JOB.
       
       Can it be done in userspace? Is the lost of data (as observed by 
       Arthur Corliss with SAR) can be avoided?
    
    3) Finally we need module that will be in charge of datas
       presentation. This will allow to be easily compatible with other
       applications.

  I will have a look to the per-job accounting patch. If I understand
well, this patch falls into the second requirement (manage groups of
processes). 

Regards,
Guillaume
