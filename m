Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbUK2Uh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbUK2Uh4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 15:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbUK2Uhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 15:37:34 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:133 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261788AbUK2Uh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 15:37:29 -0500
Subject: Re: [PATCH] CKRM 1/10: Base CKRM Events
From: Dave Hansen <haveblue@us.ibm.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
In-Reply-To: <E1CYqXA-00056l-00@w-gerrit.beaverton.ibm.com>
References: <E1CYqXA-00056l-00@w-gerrit.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1101760605.9548.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 29 Nov 2004 12:36:45 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-29 at 10:46, Gerrit Huizenga wrote:
> +#define CKRM_DEF_CB(EV,fct)					\
> +static inline void ckrm_cb_##fct(void)				\
> +{								\
> +         ckrm_invoke_event_cb_chain(CKRM_EVENT_##EV,NULL);      \
> +}

The sysfs code has a bunch of these, and I think it's one of the hardest
to follow and least palatable parts of working with it.  It makes
finding real declarations hard, and can make debugging a pain if
something goes wrong.  You get an error in ckrm_cb_FOO(), cscope or grep
for 'ckrm_cb_FOO' and scratch your head when you come up with squat.  

-- Dave

