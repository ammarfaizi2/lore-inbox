Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161200AbWBUAcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161200AbWBUAcI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 19:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161209AbWBUAcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 19:32:08 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5599 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161200AbWBUAcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 19:32:07 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org, B.Steinbrink@gmx.de,
       viro@ftp.linux.org.uk
Subject: Re: + daemonize-detach-from-current-namespace.patch added to -mm
 tree
References: <200602200438.k1K4ct5n013388@shell0.pdx.osdl.net>
	<1140425218.2979.14.camel@laptopd505.fenrus.org>
	<m1ek1ymmec.fsf@ebiederm.dsl.xmission.com>
	<20060220020943.1d9eac25.akpm@osdl.org>
	<m13bidnbni.fsf@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 20 Feb 2006 17:30:42 -0700
In-Reply-To: <m13bidnbni.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
 message of "Mon, 20 Feb 2006 11:11:13 -0700")
Message-ID: <m1irr94kp9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Andrew Morton <akpm@osdl.org> writes:
>
>
> Thanks.  This sounds worth investigating.

Ok I after looking I agree that the kthread API is the way to go long term.
If no one beats me to it I will look at this after I get some of pending
patches merged.

I am still concerned that we might want to launch user space processes
in non-default namespace but it is almost certainly not guaranteed to
be the namespace from where we see the event happen, so inheriting the
namespace in the wrong thing in all cases I can think of.

Eric
