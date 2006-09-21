Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751677AbWIUWHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbWIUWHv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 18:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbWIUWHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 18:07:51 -0400
Received: from smtp-out.google.com ([216.239.45.12]:19252 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751676AbWIUWHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 18:07:50 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=jFrFeq1ARYKMGiWhnCswPYPnyXi2aZ8ZKYtbUpfHX0Uq+ZuzsOUMY9arDnNlIf6jp
	3Bb1+rdH6x65iZtZjnRLQ==
Message-ID: <6599ad830609211507m1f5965d8ucfcb58dd86c97c74@mail.google.com>
Date: Thu, 21 Sep 2006 15:07:42 -0700
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Cc: sekharan@us.ibm.com, npiggin@suse.de, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rohitseth@google.com, devel@openvz.org,
       clameter@sgi.com
In-Reply-To: <20060921145946.8d9ace73.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609201252030.32409@schroedinger.engr.sgi.com>
	 <1158798715.6536.115.camel@linuxchandra>
	 <20060920173638.370e774a.pj@sgi.com>
	 <6599ad830609201742h71d112f4tae8fe390cb874c0b@mail.google.com>
	 <1158803120.6536.139.camel@linuxchandra>
	 <6599ad830609201852k12cee6eey9086247c9bdec8b@mail.google.com>
	 <1158869186.6536.205.camel@linuxchandra>
	 <6599ad830609211310s4e036e55h89bab26432d83c11@mail.google.com>
	 <20060921145946.8d9ace73.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/06, Paul Jackson <pj@sgi.com> wrote:
>
> Can the generic container avoid performance bottlenecks due to locks
> or other hot cache lines on the main code paths for fork, exit, page
> allocation and task scheduling?

Page allocation and task scheduling are resource controller issues,
not generic process container issues. The generic process containers
would have essentially the same overheads for fork/exit that cpusets
have currently.

Paul
