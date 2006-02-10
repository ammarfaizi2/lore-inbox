Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWBJGET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWBJGET (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 01:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWBJGET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 01:04:19 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6324 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751152AbWBJGER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 01:04:17 -0500
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       Linus Torvalds <torvalds@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
References: <43E38BD1.4070707@openvz.org>
	<1139243874.6189.71.camel@localhost.localdomain>
	<m13biwnxkc.fsf@ebiederm.dsl.xmission.com>
	<200602101541.07631.ncunningham@cyclades.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 09 Feb 2006 23:01:26 -0700
In-Reply-To: <200602101541.07631.ncunningham@cyclades.com> (Nigel
 Cunningham's message of "Fri, 10 Feb 2006 15:40:56 +1000")
Message-ID: <m1d5hvzr9l.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@cyclades.com> writes:

> Am I missing something? I though migration referred only to userspace 
> processes. Software suspend on the other hand, deals with the whole system, 
> of which process data/context is only a part.

The problem domain is user process and the kernel state they depend on.
Implementation wise we are looking at two totally different problems.

However the effects should be similar if the set of processes to
migrate are all of the processes in the system.

For most of the interesting cases migration does not need to be that
ambitious.

Eric
