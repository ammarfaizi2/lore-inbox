Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbVLPMsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbVLPMsV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 07:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbVLPMsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 07:48:05 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62163 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932235AbVLPMr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 07:47:56 -0500
To: Jamie Lokier <jamie@shareable.org>
Cc: JANAK DESAI <janak@us.ibm.com>, viro@ftp.linux.org.uk, chrisw@osdl.org,
       dwmw2@infradead.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/9] unshare system call: system call handler
 function
References: <1134513959.11972.167.camel@hobbs.atlanta.ibm.com>
	<m1k6e687e2.fsf@ebiederm.dsl.xmission.com>
	<43A1D435.5060602@us.ibm.com>
	<m1d5jy83nr.fsf@ebiederm.dsl.xmission.com>
	<43A24362.6000602@us.ibm.com>
	<20051216105048.GA32305@mail.shareable.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 16 Dec 2005 05:46:23 -0700
In-Reply-To: <20051216105048.GA32305@mail.shareable.org> (Jamie Lokier's
 message of "Fri, 16 Dec 2005 10:50:48 +0000")
Message-ID: <m1wti56wgw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> Like clone(), unshare() will have to change from year to year, as new
> flags are added.  It would be good if the default behaviour of 0 bits
> to unshare() also did the right thing, so that programs compiled in
> 2006 still function as expected in 2010.  Hmm, this
> forward-compatibility does not look pretty.

Why all it requires is that whenever someone updates clone they update
unshare.  Given the tiniest bit of refactoring we should be
able to share all of the interesting code paths.

Which should also improve maintenance considerably.

Eric
