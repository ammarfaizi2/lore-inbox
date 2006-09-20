Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWITSnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWITSnL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWITSnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:43:10 -0400
Received: from smtp-out.google.com ([216.239.45.12]:41427 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932239AbWITSnI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:43:08 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=dNvoaVSW+0ZYZFLgPNlp6qEDWtUZaSVgukW2iXT7wJ3Qsdpv8upi5xFZZTCnubQMs
	PMRtPRiYmtfSieGHXucVA==
Message-ID: <6599ad830609201143h19f6883wb388666e27913308@mail.google.com>
Date: Wed, 20 Sep 2006 11:43:02 -0700
From: "Paul Menage" <menage@google.com>
To: sekharan@us.ibm.com
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Cc: "Christoph Lameter" <clameter@sgi.com>, npiggin@suse.de,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>, pj@sgi.com,
       "Rohit Seth" <rohitseth@google.com>, devel@openvz.org
In-Reply-To: <1158777240.6536.89.camel@linuxchandra>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	 <1158777240.6536.89.camel@linuxchandra>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/06, Chandra Seetharaman <sekharan@us.ibm.com> wrote:
> > We already have such a functionality in the kernel its called a cpuset. A
>
> Christoph,
>
> There had been multiple discussions in the past (as recent as Aug 18,
> 2006), where we (Paul and CKRM/RG folks) have concluded that cpuset and
> resource management are orthogonal features.
>
> cpuset provides "resource isolation", and what we, the resource
> management guys want is work-conserving resource control.

CPUset provides two things:

- a generic process container abstraction

- "resource controllers" for CPU masks and memory nodes.

Rather than adding a new process container abstraction, wouldn't it
make more sense to change cpuset to make it more extensible (more
separation between resource controllers), possibly rename it to
"containers", and let the various resource controllers fight it out
(e.g. zone/node-based memory controller vs multiple LRU controller,
CPU masks vs a properly QoS-based CPU scheduler, etc)

Or more specifically, what would need to be added to cpusets to make
it possible to bolt the CKRM/RG resource controllers on to it?

Paul
