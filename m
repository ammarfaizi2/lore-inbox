Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWGKHyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWGKHyl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWGKHyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:54:41 -0400
Received: from cimai.net4.nerim.net ([62.212.121.89]:51095 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750707AbWGKHyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:54:40 -0400
From: Cedric Le Goater <clg@fr.ibm.com>
Message-Id: <20060711075051.382004000@localhost.localdomain>
User-Agent: quilt/0.45-1
Date: Tue, 11 Jul 2006 09:50:51 +0200
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Cc: Kirill Korotaev <dev@openvz.org>
Cc: Andrey Savochkin <saw@sw.ru>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Herbert Poetzl <herbert@13thfloor.at>
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>
Subject: [PATCH -mm 0/7] execns syscall and user namespace
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

The following patchset adds the user namespace and a new syscall execns.

The user namespace will allow a process to unshare its user_struct table,
resetting at the same time its own user_struct and all the associated
accounting.

The purpose of execns is to make sure that a process unsharing a namespace
is free from any reference in the previous namespace. the execve() semantic
seems to be the best candidate as it already flushes the previous process
context.

Thanks for reviewing, sharing, flaming !

C.


