Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWCNSpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWCNSpU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 13:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbWCNSpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 13:45:20 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59592 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751306AbWCNSpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 13:45:19 -0500
To: Kirill Korotaev <dev@sw.ru>
Cc: "Dave Hansen <haveblue@us.ibm.com> Cedric Le Goater" <clg@fr.ibm.com>,
       Herbert Poetzl <herbert@13thfloor.at>, <linux-kernel@vger.kernel.org>
Subject: question: pid space semantics.
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 14 Mar 2006 11:43:38 -0700
In-Reply-To: <1142282940.27590.17.camel@localhost.localdomain> (Dave
 Hansen's message of "Mon, 13 Mar 2006 12:48:59 -0800")
Message-ID: <m1veuglvdx.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
References: <1142282940.27590.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To retain any part of the existing unix process management
we need some processes that show up in multiple pid spaces.

To allow for migration it must be possible for the pids in those pid
spaces to be different.

It is undesirable in the normal case of affairs to allocate more
than one pid per process.

Given the small range of pid values these constraints make an
efficient and general pid space solution challenging.

The question:
  If we could add additional pid values in different pid spaces to a
  process with a syscall upon demand would that lead to an
  implementation everyone could use? 

I assume most processes by default only have a pid value in a single
pid space.

The reason I ask is that I believe I know how to implement a cheap
general mechanism for adding additional pids to a process.

Eric
