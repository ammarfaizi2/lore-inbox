Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWAYPLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWAYPLO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 10:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWAYPLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 10:11:14 -0500
Received: from pat.uio.no ([129.240.130.16]:23270 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751214AbWAYPLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 10:11:13 -0500
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Cedric Le Goater <clg@fr.ibm.com>
In-Reply-To: <m1ek2wk4ro.fsf@ebiederm.dsl.xmission.com>
References: <20060117143258.150807000@sergelap>
	 <20060117143326.283450000@sergelap>
	 <1137511972.3005.33.camel@laptopd505.fenrus.org>
	 <20060117155600.GF20632@sergelap.austin.ibm.com>
	 <1137513818.14135.23.camel@localhost.localdomain>
	 <1137518714.5526.8.camel@localhost.localdomain>
	 <20060118045518.GB7292@kroah.com>
	 <1137601395.7850.9.camel@localhost.localdomain>
	 <m1fyniomw2.fsf@ebiederm.dsl.xmission.com>
	 <43D14578.6060801@watson.ibm.com>
	 <m1hd7xmylo.fsf@ebiederm.dsl.xmission.com>
	 <43D52592.8080709@watson.ibm.com>
	 <m1oe22lp69.fsf@ebiederm.dsl.xmission.com>
	 <1138050684.24808.29.camel@localhost.localdomain>
	 <m1bqy2ljho.fsf@ebiederm.dsl.xmission.com>
	 <1138062125.24808.47.camel@localhost.localdomain>
	 <m17j8pl95v.fsf@ebiederm.dsl.xmission.com>
	 <1138137060.14675.73.camel@localhost.localdomain>
	 <1138137305.2977.92.camel@laptopd505.fenrus.org>
	 <m1ek2wk4ro.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Wed, 25 Jan 2006 10:10:11 -0500
Message-Id: <1138201811.8720.9.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.028, required 12,
	autolearn=disabled, AWL 1.78, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-25 at 02:58 -0700, Eric W. Biederman wrote:
> >> On Maw, 2006-01-24 at 12:26 -0700, Eric W. Biederman wrote:
> >> > There is at least NFS lockd that appreciates having a single integer
> >> > per process unique identifier.  So there is a practical basis for
> >> > wanting such a thing.

The NFS lock manager mainly wants a unique 32-bit identifier that can
follow clone(CLONE_FILES). The reason is that the Linux VFS is forced to
use the pointer to the file table as the "process identifier" for posix
locks (i.e. fcntl() locks).

Cheers,
  Trond

