Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423515AbWJZN05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423515AbWJZN05 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 09:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423516AbWJZN05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 09:26:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51412 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1423515AbWJZN04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 09:26:56 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <45409DD5.7050306@sw.ru> 
References: <45409DD5.7050306@sw.ru>  <453F6D90.4060106@sw.ru> <453F58FB.4050407@sw.ru> <20792.1161784264@redhat.com> <21393.1161786209@redhat.com> 
To: Vasily Averin <vvs@sw.ru>
Cc: Neil Brown <neilb@suse.de>, Jan Blunck <jblunck@suse.de>,
       Olaf Hering <olh@suse.de>, Balbir Singh <balbir@in.ibm.com>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [Q] missing unused dentry in prune_dcache()? 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 26 Oct 2006 14:25:29 +0100
Message-ID: <19898.1161869129@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Averin <vvs@sw.ru> wrote:

> Therefore I've removed break of cycle and insert this dentry to head of the
> list. Theoretically it can lead to the second using of the same dentry,
> however I do not think that it is a big problem.

Hmmm...  Or maybe it could be a problem.  If whenever we find the dentry we
stick it back on the head of the list, this could be a problem as we're
traversing the list from tail to head.

David
