Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVDYV1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVDYV1N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 17:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVDYV03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 17:26:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:7858 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261231AbVDYVZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 17:25:57 -0400
Date: Mon, 25 Apr 2005 14:25:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] dlm: build
Message-Id: <20050425142525.70e72e93.akpm@osdl.org>
In-Reply-To: <20050425151333.GH6826@redhat.com>
References: <20050425151333.GH6826@redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Teigland <teigland@redhat.com> wrote:
>
>  +config DLM 
>  +	tristate "Distributed Lock Manager (DLM)"
>  +	help
>  +	A general purpose distributed lock manager for kernel or userspace
>  +	applications.
>  +
>  +config DLM_DEVICE
>  +	tristate "DLM device for userspace access"
>  +	depends on DLM
>  +	help
>  +	This module creates a misc device through which the dlm lockspace
>  +	and locking functions become available to userspace applications
>  +	(usually through the libdlm library).
>  +
>  +config DLM_DEBUG
>  +	bool "DLM debugging"
>  +	depends on DLM
>  +	help
>  +	Under the debugfs mount point, the name of each lockspace will
>  +	appear as a file in the "dlm" directory.  The output is the
>  +	list of resource and locks the local node knows about.
>  +
>  +endmenu

Shouldn't it enable SCTP?  Depend on NET?

(I agree with Jesper's various comments btw)
