Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbUC2EYC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 23:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbUC2EYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 23:24:02 -0500
Received: from twinlark.arctic.org ([168.75.98.6]:3752 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S262609AbUC2EYB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 23:24:01 -0500
Date: Sun, 28 Mar 2004 20:23:59 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Ulrich Drepper <drepper@redhat.com>
cc: "linux-kern >> Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: For the almost 4-year anniversary: O_CLOEXEC again
In-Reply-To: <40677D1B.9060801@redhat.com>
Message-ID: <Pine.LNX.4.58.0403282019280.22832@twinlark.arctic.org>
References: <40677D1B.9060801@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Mar 2004, Ulrich Drepper wrote:

> The proposed solution is simple and already implemented on some systems
> (QNX, BeOS, maybe more).  Beside the definition of O_CLOEXEC the
> untested patch below should be all that's needed.  It does *not* solve
> the related problem of socket descriptors etc.  I've no good idea for

we could create new socket, socketpair, accept, and pipe, system calls
with an extra flags argument.  plus some similar solution to account for
dup/dup2/F_DUPFD as well.

how many other fd creating syscalls did i miss? :)

-dean
