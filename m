Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWAUKet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWAUKet (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 05:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWAUKet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 05:34:49 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6101 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932115AbWAUKes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 05:34:48 -0500
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>, linux-kernel@vger.kernel.org,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 00/34] PID Virtualization Overview
References: <1137517698.8091.29.camel@localhost.localdomain>
	<43CD32F0.9010506@FreeBSD.org>
	<1137521557.5526.18.camel@localhost.localdomain>
	<1137522550.14135.76.camel@localhost.localdomain>
	<1137610912.24321.50.camel@localhost.localdomain>
	<1137612537.3005.116.camel@laptopd505.fenrus.org>
	<1137613088.24321.60.camel@localhost.localdomain>
	<1137624867.1760.1.camel@localhost.localdomain>
	<1137654906.2993.10.camel@laptopd505.fenrus.org>
	<m1k6cvo555.fsf@ebiederm.dsl.xmission.com>
	<20060120202339.GB13265@sergelap.austin.ibm.com>
	<43D14931.7010305@watson.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 21 Jan 2006 03:34:25 -0700
In-Reply-To: <43D14931.7010305@watson.ibm.com> (Hubertus Franke's message of
 "Fri, 20 Jan 2006 15:33:53 -0500")
Message-ID: <m1u0bxna32.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke <frankeh@watson.ibm.com> writes:

> As odd as this looks .. it does have the benefits and anything that avoids
> potential problems.
>
> On the other hand you might run into problems with the following.
>
> 		char *str = task_str(tsk);
>
> Eitherway .. I don't think these are the big fish to fry now :-)

Except there are really no small fish :)

This solves the one really ugly part of my current patch,
that I had simply not thought through.

There is already something similar for paths in the fs
namespace.

char * d_path(struct dentry *dentry, struct vfsmount *vfsmnt,
				char *buf, int buflen);
Which does exactly this.

Now frequently it is passed in a page sized buffer so
it's not quite the same but close enough.

Eric
