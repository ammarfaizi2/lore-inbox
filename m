Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWITXxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWITXxm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 19:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWITXxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 19:53:41 -0400
Received: from smtp-out.google.com ([216.239.45.12]:44332 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750777AbWITXxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 19:53:40 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=CrDpLvqmVrhJsBO5Ako3LtR6HO3uEY6ysFuXkEvV/VaJA7zbtVir+5Ne1zafw52lz
	KIWZat0IYj/dgVBhYTNgA==
Message-ID: <6599ad830609201653g4f44a4frb308eaeb63f83d2a@mail.google.com>
Date: Wed, 20 Sep 2006 16:53:30 -0700
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Cc: alan@lxorguk.ukuu.org.uk, clameter@sgi.com, npiggin@suse.de,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, devel@openvz.org
In-Reply-To: <20060920163722.1442c5c1.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	 <1158773699.7705.19.camel@localhost.localdomain>
	 <6599ad830609201030w38b6ae59ia0d4a4ccabb47054@mail.google.com>
	 <20060920163722.1442c5c1.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/06, Paul Jackson <pj@sgi.com> wrote:
>
> The way you "associate" a file with a cpuset is to have some task in
> that cpuset open that file and touch its pages -- where that task does
> so before any other would be user of the file.

An alternative would be a way of binding files (or directory
hierarchies) to a particular set of memory nodes. Then you wouldn't
need to pre-fault the data. Extended attributes might be one way of
doing it.

>
> Such pre-touching of files is common occurrence on the HPC (High Perf
> Comp.) apps that run on the big honkin NUMA iron where cpusets were
> born.  I'm guessing that someone hosting 5000 web servers would rather
> not deal with that particular hastle.

I'm looking at it from the perspective of job control systems that
need to have a good idea what big datasets the jobs running under them
are touching/sharing.

Paul
