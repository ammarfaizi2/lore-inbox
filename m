Return-Path: <linux-kernel-owner+w=401wt.eu-S932822AbXALIKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932822AbXALIKw (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 03:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932825AbXALIKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 03:10:52 -0500
Received: from smtp-out.google.com ([216.239.33.17]:54186 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932822AbXALIKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 03:10:52 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=U8Cp9fMu5ECKwXEohLUpSvJgDs7lxVpujFSxJlcpvRThLEewRGauFHJgMymYErjpp
	mZwKgOEJUPp6+vGvGBbIg==
Message-ID: <6599ad830701120010u11f24bfdxeb3e8bfbd8bdba40@mail.gmail.com>
Date: Fri, 12 Jan 2007 00:10:32 -0800
From: "Paul Menage" <menage@google.com>
To: balbir@in.ibm.com
Subject: Re: [ckrm-tech] [PATCH 3/6] containers: Add generic multi-subsystem API to containers
Cc: vatsa@in.ibm.com, sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, xemul@sw.ru, dev@sw.ru,
       containers@lists.osdl.org, pj@sgi.com, mbligh@google.com,
       winget@google.com, rohitseth@google.com, serue@us.ibm.com,
       devel@openvz.org
In-Reply-To: <45A72AE0.9010209@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061222141442.753211763@menage.corp.google.com>
	 <20061222145216.574346828@menage.corp.google.com>
	 <45A50CA5.6070101@in.ibm.com>
	 <6599ad830701111453t62bec38cl9534263002f48a15@mail.gmail.com>
	 <45A72AE0.9010209@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/07, Balbir Singh <balbir@in.ibm.com> wrote:
> to 0. To walk the hierarchy, I have no root now since I do not have
> any task context. I was wondering if exporting the rootnode or providing
> a function to export the rootnode of the mounter hierarchy will make
> programming easier.

Ah - I misunderstood what you were looking for before.

>
> Something like
>
> struct container *get_root_container(struct container_subsys *ss)
> {
>        return &rootnode[ss->hierarchy];
> }

Yes, something like that sounds fine - except that it would be

return &rootnode[ss->hierarchy].top_container;

Paul
