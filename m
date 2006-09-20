Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWITTvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWITTvM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 15:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWITTvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 15:51:11 -0400
Received: from smtp-out.google.com ([216.239.45.12]:61157 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932311AbWITTvK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 15:51:10 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=x3Ze+93wrdBHQbfwYtOmhyEbd9InVitK4dMv68IhdnOylZMLgO/N/rvD5aMQITCZh
	KZa+DoSY+Mrlq0viNzWRQ==
Message-ID: <6599ad830609201251l3684c0d5q7ce6d054470a8663@mail.google.com>
Date: Wed, 20 Sep 2006 12:51:00 -0700
From: "Paul Menage" <menage@google.com>
To: "Christoph Lameter" <clameter@sgi.com>
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Cc: "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Linux Memory Management" <linux-mm@kvack.org>,
       "Rohit Seth" <rohitseth@google.com>, devel@openvz.org
In-Reply-To: <Pine.LNX.4.64.0609201247300.32409@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <4510D3F4.1040009@yahoo.com.au> <1158751720.8970.67.camel@twins>
	 <4511626B.9000106@yahoo.com.au> <1158767787.3278.103.camel@taijtu>
	 <451173B5.1000805@yahoo.com.au>
	 <1158774657.8574.65.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609201051550.31636@schroedinger.engr.sgi.com>
	 <1158775586.28174.27.camel@lappy>
	 <Pine.LNX.4.64.0609201247300.32409@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/06, Christoph Lameter <clameter@sgi.com> wrote:
> On Wed, 20 Sep 2006, Peter Zijlstra wrote:
>
> > > Which comes naturally with cpusets.
> >
> > How are shared mappings dealt with, are pages charged to the set that
> > first faults them in?
>
> They are charged to the node from which they were allocated. If the
> process is restricted to the node (container) then all pages allocated
> are are charged to the container regardless if they are shared or not.
>

Or you could use the per-vma mempolicy support to bind a large data
file to a particular node, and track shared file usage that way.

Paul
