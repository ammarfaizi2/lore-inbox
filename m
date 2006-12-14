Return-Path: <linux-kernel-owner+w=401wt.eu-S1751891AbWLNAza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbWLNAza (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 19:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbWLNAza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 19:55:30 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50376 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbWLNAz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 19:55:29 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Containers <containers@lists.osdl.org>,
       Oleg Nesterov <oleg@tv-sign.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/12] tty layer and misc struct pid conversions
References: <m1y7pcoy5w.fsf@ebiederm.dsl.xmission.com>
	<20061213141036.f8cac5e7.akpm@osdl.org>
Date: Wed, 13 Dec 2006 17:54:54 -0700
In-Reply-To: <20061213141036.f8cac5e7.akpm@osdl.org> (Andrew Morton's message
	of "Wed, 13 Dec 2006 14:10:36 -0800")
Message-ID: <m164cfpa8x.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Wed, 13 Dec 2006 04:03:39 -0700
> ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>> The aim of this patch set is to start wrapping up the struct pid
>> conversions.
>
> hm, it touches a lot of tricky code which few people are familar
> with.  Worried.

Reasonable concern.  The good thing is that the only big change was that
struct pid is reference counted while old style pids are not.  Which
means that most of the pieces are simple substitutions.  Although I admit
checking that the reference is correct especially in the tty layer
is tricky.

Eric
