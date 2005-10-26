Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbVJZCWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbVJZCWV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 22:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbVJZCWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 22:22:21 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:15532 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932520AbVJZCWU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 22:22:20 -0400
Subject: Re: [ckrm-tech] Re: [PATCH 00/02] Process Events Connector
From: Matt Helsley <matthltc@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Jesse Barnes <jbarnes@engr.sgi.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Badari Pulavarty <pbadari@us.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Erich Focht <efocht@hpce.nec.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Gerrit Huizenga <gh@us.ibm.com>, Adrian Bunk <bunk@stusta.de>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>
In-Reply-To: <20051026014852.GE5856@shell0.pdx.osdl.net>
References: <1130285260.10680.194.camel@stark>
	 <20051026003430.GA27680@kroah.com> <1130288437.10680.236.camel@stark>
	 <20051026012216.GD5856@shell0.pdx.osdl.net>
	 <1130290233.10680.262.camel@stark>
	 <20051026014852.GE5856@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Tue, 25 Oct 2005 19:13:22 -0700
Message-Id: <1130292802.10680.283.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-25 at 18:48 -0700, Chris Wright wrote:
> * Matt Helsley (matthltc@us.ibm.com) wrote:
> > 	It seems to me that this is the consensus here and on LSE-Tech.
> > This patch addresses the needs of ELSA and CKRM and is amenable to using
> > the patches recently proposed on lse-tech to pull out the common piece.
> 
> Sounds good.  What about the SGI needs (for PAGG)?  They just posted
> pnotify pretty recently.   Or is that what you mean by consensus and
> possible use of 'task notifiers'?
> 
> thanks,
> -chris

	If this patch used pnotify it would be much more complicated and it
would need to attach small pieces of data to each task. However there
have been some alternative proposals. The 'task_notifier' patch posted
by Jack Steiner was much closer to what this patch needs:
http://marc.theaimsgroup.com/?l=lse-tech&m=112869558116290&w=2

	'task_notifier' is smaller and easier to review but still requires
per-task data that would complicate the Process Events Connector patch.
There has been some discussion in the above thread on how to address the
per-task data/notification needs of PAGG and the all-task notification
needs of ELSA and CKRM.

Cheers,
	-Matt Helsley

