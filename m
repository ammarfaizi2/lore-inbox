Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbTFOWXr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 18:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbTFOWXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 18:23:47 -0400
Received: from corky.net ([212.150.53.130]:36772 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S262930AbTFOWXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 18:23:46 -0400
Date: Mon, 16 Jun 2003 01:37:34 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Ahmed Masud <masud@googgun.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <1055459980.2388.14.camel@laptop-linux>
Message-ID: <Pine.LNX.4.44.0306160132300.9881-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jun 2003, Nigel Cunningham wrote:

> Hi.
>
> On Wed, 2003-05-14 at 11:58, Yoav Weiss wrote:
> > Actually, I forgot that swsusp is now included.  I haven't tried it in a
> > while.  Anyone knows if its stable enough to start playing with encrypting
> > it ?
>
> Sorry for the slow response - I guess Pavel didn't notice your question
> either. In it's current form in the 2.5 kernel, swsusp is stable enough
> to try encrypting the data. However you might want to wait as the 2.4
> version is nearly at its 1.0 release, and the plan is for me to then
> start submitting a whole swag of patches that will make the code much
> more feature complete. The 2.4 code includes support for compressing the
> image; I guess we'd want to hook encryption in at the same point (it
> will use BIO calls, not the swap read/write routines).
>

Sounds great.  I'll wait until the patches are submitted before
introducing any changes.  And the compression hooks sound like the right
place to add encryption.  Just be sure to encrypt AFTER compression and
not vice versa.

	Yoav Weiss

