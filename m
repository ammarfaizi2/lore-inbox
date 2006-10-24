Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161162AbWJXSrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161162AbWJXSrU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 14:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161170AbWJXSrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 14:47:20 -0400
Received: from smtp-out.google.com ([216.239.45.12]:58430 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1161162AbWJXSrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 14:47:19 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=KQbtJl1P6QAFgpuRK3jwwmb3tVyz3cIkL6MIbqK2trKnom5CAJams2nKxletZschV
	TfzdyKbP1xlAEiVgM1Qjw==
Message-ID: <65dd6fd50610241147i70c978daueba7acf229fa5f23@mail.gmail.com>
Date: Tue, 24 Oct 2006 11:47:14 -0700
From: "Ollie Wild" <aaw@google.com>
To: "Peter Zijlstra" <a.p.zijlstra@chello.nl>
Subject: Re: Removing MAX_ARG_PAGES (request for comments/assistance)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1161712748.24143.54.camel@taijtu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <65dd6fd50610101705t3db93a72sc0847cd120aa05d3@mail.gmail.com>
	 <1160572460.2006.79.camel@taijtu>
	 <65dd6fd50610111448q7ff210e1nb5f14917c311c8d4@mail.gmail.com>
	 <65dd6fd50610241048h24af39d9ob49c3816dfe1ca64@mail.gmail.com>
	 <1161712748.24143.54.camel@taijtu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll have another look tomorrow, but I too don't have access to a funny
> platform, so I can be of limited help implementing the missing stack
> model. - that was all that is missing, right?
>
> Peter

That's the main technical item.  I guess I was hoping for some more
general feedback regarding the desirability of this patch: "Yes, this
is good.  Polish it off and we'll incorporate it," "No, we think the
status quo is fine," or something along those lines.

There is one point I forgot to mention.  I'm not sure what to do with
the audit_bprm() function.  It tries to copy the entire argument array
into a kmalloc'ed region, which isn't gonig to fly if we allow the
argument list to grow arbitrarily large.

Ollie
