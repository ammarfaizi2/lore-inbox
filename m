Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbUCDJk4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 04:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUCDJkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 04:40:55 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:3549 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S261612AbUCDJkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 04:40:45 -0500
To: "Michael Frank" <mhf@linuxmail.org>
Cc: "kernel mailing list" <linux-kernel@vger.kernel.org>
Subject: Re: How to black list shared libraries and executable
References: <opr4bsvwbj4evsfm@smtp.pacific.net.th>
From: Jes Sorensen <jes@wildopensource.com>
Date: 04 Mar 2004 04:40:26 -0500
In-Reply-To: <opr4bsvwbj4evsfm@smtp.pacific.net.th>
Message-ID: <yq0d67tt0fp.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Michael" == Michael Frank <mhf@linuxmail.org> writes:

Michael> Just wondering on how to build a kernel-level facility which
Michael> would require shared libraries and executables to be "keyed"
Michael> or even "signed" to run on linux.

Michael> This is to prevent execution of software not specifically
Michael> authorized.

The shared libraries are going to cause you 'issues' since these are
all loaded by dynamic linker. All the kernel loads is ld.so, the
rest of them are mmap'ed from userland.

So if you want to take this approach, you would have to hack a special
ld.so that only allows your authorized libraries and only authorize
the kernel to load that dynamic linker. Otherwise you have to do
content validation for all mmap operations.

Jes
