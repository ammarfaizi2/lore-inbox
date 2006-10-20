Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992524AbWJTHHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992524AbWJTHHE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 03:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992527AbWJTHHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 03:07:04 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64480 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S2992524AbWJTHHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 03:07:01 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Albert Cahalan <acahalan@gmail.com>, Cal Peake <cp@absolutedigital.net>
Subject: [CFT] Grep to find users of sys_sysctl.
References: <787b0d920610181123q1848693ajccf7a91567e54227@mail.gmail.com>
	<Pine.LNX.4.64.0610181129090.3962@g5.osdl.org>
	<Pine.LNX.4.64.0610181443170.7303@lancer.cnet.absolutedigital.net>
	<20061018124415.e45ece22.akpm@osdl.org>
	<m17iyw7w92.fsf_-_@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0610191218020.32647@lancer.cnet.absolutedigital.net>
Date: Fri, 20 Oct 2006 01:05:18 -0600
In-Reply-To: <Pine.LNX.4.64.0610191218020.32647@lancer.cnet.absolutedigital.net>
	(Cal Peake's message of "Thu, 19 Oct 2006 12:25:20 -0400 (EDT)")
Message-ID: <m1wt6v4gcx.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Anyone who is interested in knowing if they have an application on
their system that actually uses sys_sysctl please run the following grep.

find / -type f  -perm /111 -exec fgrep 'sysctl@@GLIBC' '{}' ';' 

The -perm /111 is an optimization to only look at executable files,
and may be omitted if you are patient.

Currently I don't expect anyone to find a match anywhere except in libpthreads,
if you find any others please let me know.

Eric
