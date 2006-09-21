Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbWIUAfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbWIUAfH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWIUAfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:35:07 -0400
Received: from smtp-out.google.com ([216.239.45.12]:47670 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750721AbWIUAfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:35:05 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=ZcV/yJJE/VlRnvILz7wK/y9asTDO9Qn6y5sD7++Sgg1atOQoNIgIcPeIWdnlM1WAp
	DNxPDq2g758XbnVDHVHIw==
Message-ID: <6599ad830609201734m1566876aya2605efaf0a5cb63@mail.google.com>
Date: Wed, 20 Sep 2006 17:34:52 -0700
From: "Paul Menage" <menage@google.com>
To: sekharan@us.ibm.com
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Cc: npiggin@suse.de, CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>, pj@sgi.com,
       "Rohit Seth" <rohitseth@google.com>, devel@openvz.org,
       "Christoph Lameter" <clameter@sgi.com>
In-Reply-To: <1158798607.6536.112.camel@linuxchandra>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	 <1158777240.6536.89.camel@linuxchandra>
	 <6599ad830609201143h19f6883wb388666e27913308@mail.google.com>
	 <1158778496.6536.95.camel@linuxchandra>
	 <6599ad830609201225k3d38afe2gea7adc2fa8067e0@mail.google.com>
	 <1158780923.6536.110.camel@linuxchandra>
	 <6599ad830609201257m22605deei25ae6a0eadb6c516@mail.google.com>
	 <1158798607.6536.112.camel@linuxchandra>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/06, Chandra Seetharaman <sekharan@us.ibm.com> wrote:
>
> What I am wondering is that whether the tight coupling of rg and cpuset
> (into a container data structure) is ok.

Can you suggest a realistic scenario in which it's not? Don't forget
that since the container abstraction is hierarchical, you don't have
to use both at the same level. So you could easily e.g. have a parent
container in which you bound to a set of memory/cpu nodes, but had no
rg limits, and several subcontainers where you configured nothing
special for cpuset parameters (so inherited the parent params) but
tweaked different rg parameters.

Paul
