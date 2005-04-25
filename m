Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVDYW2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVDYW2R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 18:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVDYW2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 18:28:16 -0400
Received: from [80.71.243.242] ([80.71.243.242]:59526 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261260AbVDYW1s (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Mon, 25 Apr 2005 18:27:48 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17005.28381.102652.36606@gargle.gargle.HOWL>
Date: Tue, 26 Apr 2005 02:27:41 +0400
To: Daniel Phillips <phillips@istop.com>
Cc: David Teigland <teigland@redhat.com>, akpm@osdl.org,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: Re: [PATCH 1b/7] dlm: core locking
In-Reply-To: <200504251644.21566.phillips@istop.com>
References: <20050425165826.GB11938@redhat.com>
	<17005.14407.228930.83593@gargle.gargle.HOWL>
	<200504251644.21566.phillips@istop.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips writes:
 > Hi Nikita,
 > 
 > On Monday 25 April 2005 14:34, you wrote:
 > >  > +
 > >  > +static int is_remote(struct dlm_rsb *r)
 > >  > +{
 > >  > + DLM_ASSERT(r->res_nodeid >= 0, dlm_print_rsb(r););
 > >  > + return r->res_nodeid ? TRUE : FALSE;
 > >  > +}
 > >
 > > This can be simply
 > >
 > >       return r->res_nodeid;
 > 
 > Not quite the same.  Perhaps you meant:
 > 
 >         return !!r->res_nodeid;

Strictly speaking yes (assuming TRUE is defined as 1), but name
is_remote() implies usages like

         if (is_remote(r)) {
                 do_something();
         }

in such contexts !! is not necessary.

 > 
 > Regards,
 > 
 > Daniel

Nikita.
