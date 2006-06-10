Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbWFJDYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWFJDYK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 23:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWFJDYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 23:24:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26521 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030216AbWFJDYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 23:24:08 -0400
Date: Fri, 9 Jun 2006 20:22:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kirill Korotaev <dev@openvz.org>
Cc: devel@openvz.org, xemul@openvz.org, linux-kernel@vger.kernel.org,
       ebiederm@xmission.com, herbert@13thfloor.at, saw@sw.ru,
       serue@us.ibm.com, sfrench@us.ibm.com, sam@vilain.net,
       haveblue@us.ibm.com, clg@fr.ibm.com
Subject: Re: [PATCH 1/6] IPC namespace core
Message-Id: <20060609202258.8442848e.akpm@osdl.org>
In-Reply-To: <44898D52.4080506@openvz.org>
References: <44898BF4.4060509@openvz.org>
	<44898D52.4080506@openvz.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jun 2006 19:01:38 +0400
Kirill Korotaev <dev@openvz.org> wrote:

> This patch implements core IPC namespace changes:
> - ipc_namespace structure
> - new config option CONFIG_IPC_NS
> - adds CLONE_NEWIPC flag
> - unshare support

`make allnoconfig'

arch/i386/kernel/init_task.o:(.data+0x1a0): undefined reference to `init_ipc_ns'
kernel/built-in.o: In function `free_nsproxy':
: undefined reference to `free_ipc_ns'
kernel/built-in.o: In function `copy_namespaces':
: undefined reference to `copy_ipcs'

