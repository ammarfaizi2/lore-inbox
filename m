Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbVKIV3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbVKIV3E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbVKIV3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:29:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4496 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751405AbVKIV3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:29:03 -0500
Message-ID: <437269BA.7030105@redhat.com>
Date: Wed, 09 Nov 2005 13:27:22 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mail/News 1.5 (X11/20051105)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@osdl.org
Subject: Re: openat()
References: <43724AB3.40309@redhat.com> <E1EZx6Q-0002zw-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1EZx6Q-0002zw-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> What's wrong with using '/proc/self/fd/N' to implement it?

I thought the intention was to have file descriptors referring to files, 
not directories, to represent the directories they are in.  In those 
cases simply using /proc/PID/fd/N/some/more/dirs wouldn't work and 
neither does /proc/PID/fd/N/../some/more/dirs.

Looking at the Sol man page again it seems they don't allow this case 
but this has to be guessed from the error codes, not the description. 
In this case the /rpco approach should be OK.

But there are always people questioning the use of /proc.  We already 
have quite a few such cases and adding more is no issue for me, but not 
relying on /proc would appease some people.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
