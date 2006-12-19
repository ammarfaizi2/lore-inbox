Return-Path: <linux-kernel-owner+w=401wt.eu-S932698AbWLSI46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698AbWLSI46 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 03:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbWLSI46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 03:56:58 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:51773 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932085AbWLSI45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 03:56:57 -0500
Date: Tue, 19 Dec 2006 11:56:49 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [take28-resend_2->0 0/8] kevent: Generic event handling mechanism.
Message-ID: <20061219085649.GA14877@2ka.mipt.ru>
References: <11663636322861@2ka.mipt.ru> <458760C9.7080504@redhat.com> <20061219045130.GA28980@2ka.mipt.ru> <458784EE.7080303@redhat.com> <20061219063838.GA23757@2ka.mipt.ru> <45879C5F.7040802@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45879C5F.7040802@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 19 Dec 2006 11:56:50 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 12:01:35AM -0800, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> >What error messages do you see and what are kevent related config
> >changes?
> 
> ARCH=um
> 
> #define CONFIG_KEVENT_USER_STAT 1
> #define CONFIG_KEVENT_PIPE 1
> #define CONFIG_KEVENT_POLL 1
> #define CONFIG_KEVENT_TIMER 1
> #define CONFIG_KEVENT 1
> #define CONFIG_KEVENT_SIGNAL 1
> #define CONFIG_KEVENT_SOCKET 1
> 
> 
> 
> In file included from kernel/kevent/kevent.c:28:
> include/linux/kevent.h: In function ‘kevent_init_file’:
> include/linux/kevent.h:220: error: ‘struct file’ has no member named 
> ‘st’
> include/linux/kevent.h: In function ‘kevent_cleanup_file’:
> include/linux/kevent.h:225: error: ‘struct file’ has no member named 
> ‘st’

Can you send me your linux/fs.h file to chek if it is correct.
Also does 'make prepare' fix the buid?

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, 
> CA ❖

-- 
	Evgeniy Polyakov
