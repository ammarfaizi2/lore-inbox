Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWIUAJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWIUAJa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWIUAJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:09:30 -0400
Received: from smtp-out.google.com ([216.239.33.17]:61005 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750800AbWIUAJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:09:29 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=o5HnCg23B0vFU6UInzqG3I1AmPMejwDePA98Fj/c09gawbJUbRsAny/IKjSR6Lzdi
	7xmBRY82uDZb4sCzzc1Xg==
Message-ID: <6599ad830609201709r3d7b5587m2fdb573e510faacc@mail.google.com>
Date: Wed, 20 Sep 2006 17:09:22 -0700
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Cc: "Christoph Lameter" <clameter@sgi.com>, rohitseth@google.com,
       npiggin@suse.de, linux-kernel@vger.kernel.org, devel@openvz.org,
       ckrm-tech@lists.sourceforge.net
In-Reply-To: <20060920170544.b4fd00f4.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609201035240.31464@schroedinger.engr.sgi.com>
	 <1158775678.8574.81.camel@galaxy.corp.google.com>
	 <20060920155815.33b03991.pj@sgi.com>
	 <Pine.LNX.4.64.0609201601450.1026@schroedinger.engr.sgi.com>
	 <1158795231.7207.21.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609201634450.1955@schroedinger.engr.sgi.com>
	 <1158795569.7207.23.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609201651001.2055@schroedinger.engr.sgi.com>
	 <20060920170544.b4fd00f4.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/06, Paul Jackson <pj@sgi.com> wrote:
>
> Yes.  There's quite a bit more to cpusets than just some form,
> any form, of CPU and Memory restriction.  I can't imagine that
> Containers, in any form, are going to replicate that API.
>

That would be one of the nice aspects of a generic process container
abstraction linked to different resource controllers - you wouldn't
need to replicate the cpuset support, you could use it in parallel
with other resource controllers. (So e.g. use the cpusets support to
pin a group of processes on to a given set of CPU/memory nodes, and
then use the CKRM/RG CPU and disk/IO controllers to limit resource
usage within those nodes)

Paul
