Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752479AbWCGCFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbWCGCFI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 21:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752480AbWCGCFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 21:05:08 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:479 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752479AbWCGCFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 21:05:06 -0500
Subject: Re: [RFC][PATCH 1/6] prepare sysctls for containers
From: Dave Hansen <haveblue@us.ibm.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, serue@us.ibm.com, frankeh@watson.ibm.com,
       clg@fr.ibm.com, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam@vilain.net>
In-Reply-To: <20060307010139.GF27645@sorel.sous-sol.org>
References: <20060306235248.20842700@localhost.localdomain>
	 <20060306235249.880CB28A@localhost.localdomain>
	 <20060307010139.GF27645@sorel.sous-sol.org>
Content-Type: text/plain
Date: Mon, 06 Mar 2006 18:04:11 -0800
Message-Id: <1141697051.9274.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-06 at 17:01 -0800, Chris Wright wrote:
> Interesting idea.  One piece that's missing is strategy for controlling
> creation the new context (assuming the data_access() will always evaluate
> into a context sensitive piece of data).  Otherwise a user can get out
> of the limits imposed by sysadmin (since they may have placed themselves
> in a context which differs from admin).

Yup, that is missing for now.  We couldn't agree on quite which
implementation we want for basic containers/vservers/vpses.  So, for
now, making it useful is left as an exercise to the reader. :)

BTW, the current code _is_ potentially context sensitive because
"current" provides much of the context that we will ever need.

-- Dave

