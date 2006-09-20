Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWITSdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWITSdd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWITSdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:33:33 -0400
Received: from smtp-out.google.com ([216.239.45.12]:29648 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932219AbWITSdc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:33:32 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=anj3qtm5TVh3RX/OPsioeb+qLAS/HXCNC4pG4IhxFN8qVwYrY/jYP9/pvEkuBRCvc
	+IUWeGERo/k3o8oJtRNvg==
Message-ID: <6599ad830609201133k68cc1a0dr683137baa4e9be30@mail.google.com>
Date: Wed, 20 Sep 2006 11:33:25 -0700
From: "Paul Menage" <menage@google.com>
To: "Peter Zijlstra" <a.p.zijlstra@chello.nl>
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Cc: rohitseth@google.com, "Nick Piggin" <nickpiggin@yahoo.com.au>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Linux Memory Management" <linux-mm@kvack.org>, devel@openvz.org,
       "Christoph Lameter" <clameter@sgi.com>
In-Reply-To: <1158776824.28174.29.camel@lappy>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <1158751720.8970.67.camel@twins> <4511626B.9000106@yahoo.com.au>
	 <1158767787.3278.103.camel@taijtu> <451173B5.1000805@yahoo.com.au>
	 <1158774657.8574.65.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609201051550.31636@schroedinger.engr.sgi.com>
	 <1158775586.28174.27.camel@lappy>
	 <1158776099.8574.89.camel@galaxy.corp.google.com>
	 <1158776824.28174.29.camel@lappy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/06, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
>
> Yes, I read that in your patches, I was wondering how the cpuset
> approach would handle this.

The VM currently has support for letting vmas define their own memory
policies - so specifying that a file-backed vma gets its memory from a
particular set of memory nodes would accomplish that for the fake-node
approach. The mechanism for setting up the per-file/per-vma policies
would probably involve something originating in struct inode or struct
address_space.

Paul
