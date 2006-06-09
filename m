Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965286AbWFIP0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965286AbWFIP0x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965287AbWFIP0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:26:52 -0400
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:43209 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S965286AbWFIP0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:26:51 -0400
Date: Fri, 9 Jun 2006 11:26:46 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Kirill Korotaev <dev@openvz.org>
cc: Andrew Morton <akpm@osdl.org>, devel@openvz.org, xemul@openvz.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ebiederm@xmission.com, herbert@13thfloor.at, saw@sw.ru,
       serue@us.ibm.com, sfrench@us.ibm.com, sam@vilain.net,
       haveblue@us.ibm.com, clg@fr.ibm.com
Subject: Re: [PATCH 1/6] IPC namespace core
In-Reply-To: <44898D52.4080506@openvz.org>
Message-ID: <Pine.LNX.4.64.0606091119450.12862@d.namei>
References: <44898BF4.4060509@openvz.org> <44898D52.4080506@openvz.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jun 2006, Kirill Korotaev wrote:

> This patch implements core IPC namespace changes:
> - ipc_namespace structure
> - new config option CONFIG_IPC_NS
> - adds CLONE_NEWIPC flag
> - unshare support
> 

Please post patches as inline text, so they can be reviewed inline.

+struct ipc_namespace {
+       struct kref     kref;
+       struct ipc_ids  *ids[3];
+
+       int             sem_ctls[4];

It'd be nice if these weren't magic numbers.



-- 
James Morris
<jmorris@namei.org>
