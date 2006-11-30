Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759060AbWK3IBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759060AbWK3IBT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 03:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759063AbWK3IBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 03:01:19 -0500
Received: from smtp-out.google.com ([216.239.45.12]:24489 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1759048AbWK3IBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 03:01:19 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=yX7pOyTseAznKzX9NHegcY9ze5bUNIEoUD8VgqDd2/zDNbjZjXh9qNxOKm/Wgd5Tp
	zVW0AjUpC+rEIOLrBn4Ug==
Message-ID: <6599ad830611300001j73ad0f32xbafb6d2a92878871@mail.gmail.com>
Date: Thu, 30 Nov 2006 00:01:06 -0800
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [PATCH 0/7] Generic Process Containers (+ ResGroups/BeanCounters)
Cc: akpm@osdl.org, sekharan@us.ibm.com, dev@sw.ru, xemul@sw.ru,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net,
       devel@openvz.org, mbligh@google.com, winget@google.com,
       rohitseth@google.com
In-Reply-To: <20061129233229.a47e0f1b.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061123120848.051048000@menage.corp.google.com>
	 <20061129233229.a47e0f1b.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/06, Paul Jackson <pj@sgi.com> wrote:
>  config PROC_PID_CPUSET
>         bool "Include legacy /proc/<pid>/cpuset file"
>         depends on CPUSETS
> +       default y if CPUSETS
>

Sounds very reasonable.

> 2) I wedged the kernel on the container_lock, doing a removal of a cpuset
>    using notify_on_release.
>

I guess I've not really tested doing interesting things from the
notify_on_release code, just checked that it successfully executed a
simple command. I'll look into it.

Thanks for the feedback.

Paul
