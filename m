Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWIVANl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWIVANl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 20:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWIVANk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 20:13:40 -0400
Received: from smtp-out.google.com ([216.239.45.12]:27735 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932128AbWIVANk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 20:13:40 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=RGEHSkqvBBXeAWdSgosAXvkziwTG7TCpZekgOfe4dEqxQJIil1PXypmKmm36QXnOu
	V4YX1YSYiE5rnvdvuRW+Q==
Message-ID: <6599ad830609211713u7356aff7k6400ddcee9651d61@mail.google.com>
Date: Thu, 21 Sep 2006 17:13:31 -0700
From: "Paul Menage" <menage@google.com>
To: sekharan@us.ibm.com
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Cc: npiggin@suse.de, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, "Paul Jackson" <pj@sgi.com>,
       rohitseth@google.com, devel@openvz.org, clameter@sgi.com
In-Reply-To: <1158883601.6536.223.camel@linuxchandra>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <20060920173638.370e774a.pj@sgi.com>
	 <6599ad830609201742h71d112f4tae8fe390cb874c0b@mail.google.com>
	 <1158803120.6536.139.camel@linuxchandra>
	 <6599ad830609201852k12cee6eey9086247c9bdec8b@mail.google.com>
	 <1158869186.6536.205.camel@linuxchandra>
	 <6599ad830609211310s4e036e55h89bab26432d83c11@mail.google.com>
	 <1158875062.6536.210.camel@linuxchandra>
	 <6599ad830609211509x17f0306qbe6d0ef86b86cbc9@mail.google.com>
	 <1158883601.6536.223.camel@linuxchandra>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/06, Chandra Seetharaman <sekharan@us.ibm.com> wrote:
> Think about what will be available to customer through a distro.
>
> There are two (competing) memory controllers in the kernel. But, distro
> can turn only one ON. Which in turn mean

Why's that? I don't see why cpuset memory nodemasks can't coexist
with, say, the RG memory controller. They're attempting to solve
different problems, and I can see situations where you might want to
use both at once.

>
> So, IMHO, it is better to sort out the differences before we get things
> in mainline kernel.

Agreed, if we can come up with a definition of e.g. memory controller
that everyone agrees is suitable for their needs. You're assuming
that's so a priori, I'm not yet convinced.

And I'm not trying to get another memory controller into the kernel,
I'm just trying to get a standard process aggregation into the kernel
(or rather, take the one that's already in the kernel and make it
possible to hook other controller frameworks into it), so that the
various memory controllers can become less intrusive patches in their
own right.

Paul
