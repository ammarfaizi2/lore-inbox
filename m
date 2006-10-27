Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752215AbWJ0OZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbWJ0OZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 10:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752212AbWJ0OZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 10:25:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44229 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1946472AbWJ0OZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 10:25:56 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <45420CAB.3060202@sw.ru> 
References: <45420CAB.3060202@sw.ru>  <453F6D90.4060106@sw.ru> <453F58FB.4050407@sw.ru> <20792.1161784264@redhat.com> <21393.1161786209@redhat.com> 
To: Vasily Averin <vvs@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: Re: [PATCH 2.6.19-rc3] VFS: missing unused dentry in prune_dcache() 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 27 Oct 2006 15:24:33 +0100
Message-ID: <27067.1161959073@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Averin <vvs@sw.ru> wrote:

> +		/* Inserting dentry to tail of the list leads to cycle */
> + 		list_add(&dentry->d_lru, &dentry_unused);
> +		dentry_stat.nr_unused++;

I'd phrase that comment differently: "Insert dentry at the head of the list as
inserting at the tail leads to a cycle".

But other than that:

Acked-By: David Howells <dhowells@redhat.com>
