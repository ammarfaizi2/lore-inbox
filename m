Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753824AbWKFVXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824AbWKFVXH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 16:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753826AbWKFVXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 16:23:06 -0500
Received: from smtp-out.google.com ([216.239.45.12]:54242 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1753824AbWKFVXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 16:23:03 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=GAQZ1H8uvQ/9gn+vCbVFMep3cklcVgS4ymsNgTLnStqBsOGMQxUn1JeMaZCMXgNfX
	gkXdE2VkONfgY/yz9NtHA==
Message-ID: <6599ad830611061322r6d11ee38hf8748e3b34f22a0b@mail.gmail.com>
Date: Mon, 6 Nov 2006 13:22:52 -0800
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [ckrm-tech] [PATCH 2/6] Cpusets hooked into containers
Cc: balbir@in.ibm.com, sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       jlan@sgi.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       mbligh@google.com, winget@google.com, rohitseth@google.com
In-Reply-To: <20061106130921.7ed66fa5.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061020183819.656586000@menage.corp.google.com>
	 <20061020190626.810567000@menage.corp.google.com>
	 <454ED769.8040302@in.ibm.com>
	 <6599ad830611061255u458a795bpca1c360cb93f253@mail.gmail.com>
	 <20061106130921.7ed66fa5.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/06, Paul Jackson <pj@sgi.com> wrote:
>
> But I presume this CONFIG_CPUSETS_LEGACY_API option means I either
> get to build a kernel that supports the new container API, or a kernel
> that supports the old cpuset API.  That does not seem useful to me.

No. The changes triggered by CONFIG_CPUSETS_LEGACY_API are:

- /proc/<pid>/cpuset is an alias for /proc/<pid>/containers
- a dummy "cpuset" filesystem exists
- mounting the "cpuset" filesystem causes:
  - the container filesystem to be mounted in its place
  - the release agent to be switched to /sbin/cpuset_release_agent
  - defaults the "cpuset" container type to be enabled

Paul
