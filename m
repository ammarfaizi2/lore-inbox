Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbUBTUBi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 15:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbUBTT5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 14:57:53 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:45740
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S261369AbUBTTnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 14:43:47 -0500
Message-ID: <40366344.9010109@redhat.com>
Date: Fri, 20 Feb 2004 11:43:00 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040215
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: possible problems with kernel threading code?
References: <40364D01.9030504@nortelnetworks.com>
In-Reply-To: <40364D01.9030504@nortelnetworks.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not that this is of any interest for this list but what the heck.

The problem is your code.

>  int schedRc = pthread_setschedparam(t1, policy, &schedParam);

There is no guarantee that t1 is filled before you it here in the newly
created thread.  Only when pthread_create() returns is the thread handle
guaranteed to be written.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
