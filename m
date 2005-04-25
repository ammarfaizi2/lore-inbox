Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVDYUpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVDYUpH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 16:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVDYUpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 16:45:06 -0400
Received: from smtp.istop.com ([66.11.167.126]:28327 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261171AbVDYUoP (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Mon, 25 Apr 2005 16:44:15 -0400
From: Daniel Phillips <phillips@istop.com>
To: Nikita Danilov <nikita@clusterfs.com>
Subject: Re: [PATCH 1b/7] dlm: core locking
Date: Mon, 25 Apr 2005 16:44:21 -0400
User-Agent: KMail/1.7
Cc: David Teigland <teigland@redhat.com>, akpm@osdl.org,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
References: <20050425165826.GB11938@redhat.com> <17005.14407.228930.83593@gargle.gargle.HOWL>
In-Reply-To: <17005.14407.228930.83593@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504251644.21566.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

On Monday 25 April 2005 14:34, you wrote:
>  > +
>  > +static int is_remote(struct dlm_rsb *r)
>  > +{
>  > + DLM_ASSERT(r->res_nodeid >= 0, dlm_print_rsb(r););
>  > + return r->res_nodeid ? TRUE : FALSE;
>  > +}
>
> This can be simply
>
>       return r->res_nodeid;

Not quite the same.  Perhaps you meant:

        return !!r->res_nodeid;

Regards,

Daniel
