Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbWAZUOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWAZUOd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 15:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWAZUOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 15:14:33 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31675 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751409AbWAZUOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 15:14:32 -0500
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       "Alan Cox <alan@lxorguk.ukuu.org.uk> Dave Hansen" 
	<haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC: Multiple instances of kernel namespaces.
References: <43CD32F0.9010506@FreeBSD.org>
	<1137521557.5526.18.camel@localhost.localdomain>
	<1137522550.14135.76.camel@localhost.localdomain>
	<1137610912.24321.50.camel@localhost.localdomain>
	<1137612537.3005.116.camel@laptopd505.fenrus.org>
	<1137613088.24321.60.camel@localhost.localdomain>
	<1137624867.1760.1.camel@localhost.localdomain>
	<m1bqy6oevn.fsf_-_@ebiederm.dsl.xmission.com>
	<20060120201353.GA13265@sergelap.austin.ibm.com>
	<m13bjhoq1r.fsf@ebiederm.dsl.xmission.com>
	<20060126194755.GA20473@MAIL.13thfloor.at>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 26 Jan 2006 13:13:45 -0700
In-Reply-To: <20060126194755.GA20473@MAIL.13thfloor.at> (Herbert Poetzl's
 message of "Thu, 26 Jan 2006 20:47:55 +0100")
Message-ID: <m1psmehhmu.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> writes:

> On Sat, Jan 21, 2006 at 03:04:16AM -0700, Eric W. Biederman wrote:
>> So in the simple case I have names like:
>> 1178/1632
>
> which is a new namespace in itself, but it doesn't matter
> as long as it uniquely and persistently identifies the
> namespace for the time it exists ... just leaves the
> question how to retrieve a list of all namespaces :)

Yes but the name of the namespace is still in the original pid namespace.
And more importantly to me it isn't a new kind of namespace.

>> If I want a guest that can keep secrets from the host sysadmin I don't
>> want transitioning into a guest namespace to come too easily.
>
> which can easily be achieved by 'marking' the namespace
> as private and/or applying certain rules/checks to the
> 'enter' procedure ...

Right.  The trick here is that you must be able to deny
transitioning into a namespace from the inside the namespace.
Or else a guest could never trust it.  Something one of my
coworkers pointed out to me.

Eric
