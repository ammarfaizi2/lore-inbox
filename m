Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263480AbUDPQNu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 12:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbUDPQNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 12:13:50 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:22485
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263480AbUDPQNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 12:13:45 -0400
Message-ID: <4080060F.7030604@redhat.com>
Date: Fri, 16 Apr 2004 09:13:03 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Riesen <ari@mbs-software.de>
CC: Michal Wronski <wrona@mat.uni.torun.pl>,
       Krzysztof Benedyczak <golbi@mat.uni.torun.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: POSIX message queues, libmqueue: mq_open, mq_unlink
References: <20040416081155.GB7815@linux-ari.internal>
In-Reply-To: <20040416081155.GB7815@linux-ari.internal>
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen wrote:

> Looking over the code in libmqueue-4.31, I noticed the checks for the
> name validity in the mq_open and mq_unlink. Why are they needed?  They
> are pointless if the code in kernel depends on the valid name,

You are contradicting yourself.

Anyway, non-absolute path names passed to the functions mean the
behavior is unspecified.  No portable application must ever do this.  It
is enforced for this reason plus if there comes a time when we want to
do something special which doesn't conflict with standard-compliant
behavior we have a possibility for that.  Unlike wh6at you think, the
tests *are* useful.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
