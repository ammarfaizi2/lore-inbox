Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbUCRIWn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 03:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbUCRIWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 03:22:43 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:61913
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S261992AbUCRIWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 03:22:41 -0500
Message-ID: <40595C43.1040907@redhat.com>
Date: Thu, 18 Mar 2004 00:22:27 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Hockin <thockin@hockin.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: sched_setaffinity usability
References: <40595842.5070708@redhat.com> <20040318081249.GA26373@hockin.org>
In-Reply-To: <20040318081249.GA26373@hockin.org>
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:

> could you just call getaffinity first?

This means copying quite some memory.

On the bright side, this would allow to have a well-defined error case
which guarantees the affinity mask is not changed if it cannot be done
completely.  Still, it might mean for some systems (and the number is
going to grow in future) to spend a lot of effort on the error case
which never really is hit.  And the affinity calls have to take a lock,
serializing code possibly quite a bit.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
