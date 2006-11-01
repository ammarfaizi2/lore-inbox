Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWKAXoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWKAXoG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 18:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWKAXoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 18:44:06 -0500
Received: from smtp-out.google.com ([216.239.33.17]:55466 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750716AbWKAXoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 18:44:03 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=IbaMR0LAQkEfrVcSZaKqIhJmhosCC7o1hC7Ph8ZLpGv3GI09ysqgPVa7KT7pPE5ef
	p5ssjga0bpKLIDpdBEwOQ==
Message-ID: <6599ad830611011543k31e6cd51v33b3464d33784e79@mail.gmail.com>
Date: Wed, 1 Nov 2006 15:43:52 -0800
From: "Paul Menage" <menage@google.com>
To: "David Rientjes" <rientjes@cs.washington.edu>
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Cc: "Srivatsa Vaddagiri" <vatsa@in.ibm.com>, "Paul Jackson" <pj@sgi.com>,
       dev@openvz.org, sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       balbir@in.ibm.com, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       matthltc@us.ibm.com, dipankar@in.ibm.com, rohitseth@google.com
In-Reply-To: <Pine.LNX.4.64N.0611011249440.30874@attu4.cs.washington.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030103356.GA16833@in.ibm.com>
	 <20061030031531.8c671815.pj@sgi.com>
	 <6599ad830610300404v1e036bb7o7ed9ec0bc341864e@mail.gmail.com>
	 <20061030042714.fa064218.pj@sgi.com>
	 <6599ad830610300953o7cbf5a6cs95000e11369de427@mail.gmail.com>
	 <20061030123652.d1574176.pj@sgi.com>
	 <6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com>
	 <Pine.LNX.4.64N.0610311951280.7538@attu4.cs.washington.edu>
	 <20061101155937.GA2928@in.ibm.com>
	 <Pine.LNX.4.64N.0611011249440.30874@attu4.cs.washington.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> So instead we make the requirement that only one container can be attached
> to any given controller.  So if container A is attached to a disk I/O
> controller, for example, then it includes all processes.  If D is attached
> to it instead, only p and q are affected by its constraints.

If by "controller" you mean "resource node" this looks on second
glance very similar in concept to the simplified approach I outlined
in my last email. Except that I'd still include a pointer from e.g. D
to the resource node for fast lookup.

Paul
