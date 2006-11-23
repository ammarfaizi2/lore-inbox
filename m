Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933053AbWKWHtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933053AbWKWHtK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 02:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933064AbWKWHtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 02:49:09 -0500
Received: from smtp-out.google.com ([216.239.45.12]:3821 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S933053AbWKWHtH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 02:49:07 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=w00u6hzMNmzfPQwLPAF5dACDtYo/c3KBda90jy7y0vDNpENmkK1Nm1Rh6b984e91w
	4hr3cjDMnyUA87AuLs2Xw==
Message-ID: <6599ad830611222348o1203357tea64fff91edca4f3@mail.gmail.com>
Date: Wed, 22 Nov 2006 23:48:56 -0800
From: "Paul Menage" <menage@google.com>
To: "Kirill Korotaev" <dev@sw.ru>
Subject: Re: [ckrm-tech] [PATCH 4/13] BC: context handling
Cc: "Andrew Morton" <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       matthltc@us.ibm.com, hch@infradead.org,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, oleg@tv-sign.ru,
       devel@openvz.org, xemul@openvz.org
In-Reply-To: <45535E11.20207@sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45535C18.4040000@sw.ru> <45535E11.20207@sw.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/06, Kirill Korotaev <dev@sw.ru> wrote:
> +
> +int bc_task_move(int pid, struct beancounter *bc, int whole)
> +{

...

> +
> +       down_write(&mm->mmap_sem);
> +       err = stop_machine_run(do_set_bcid, &data, NR_CPUS);
> +       up_write(&mm->mmap_sem);

Isn't this a little heavyweight for moving a task into/between beancounters?

Paul
