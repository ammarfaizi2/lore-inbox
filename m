Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161255AbWGNQf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161255AbWGNQf7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 12:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161259AbWGNQf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 12:35:59 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:57504 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161255AbWGNQf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 12:35:58 -0400
Subject: Re: [PATCH -mm 5/7] add user namespace
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
In-Reply-To: <m17j2gw76o.fsf@ebiederm.dsl.xmission.com>
References: <20060711075051.382004000@localhost.localdomain>
	 <20060711075420.937831000@localhost.localdomain>
	 <m1fyh7eb9i.fsf@ebiederm.dsl.xmission.com> <44B50088.1010103@fr.ibm.com>
	 <m1psgaag7y.fsf@ebiederm.dsl.xmission.com> <44B684A5.2040008@fr.ibm.com>
	 <20060713174721.GA21399@sergelap.austin.ibm.com>
	 <m1mzbd1if1.fsf@ebiederm.dsl.xmission.com>
	 <1152815391.7650.58.camel@localhost.localdomain>
	 <m1wtahz5u2.fsf@ebiederm.dsl.xmission.com>
	 <1152821011.24925.7.camel@localhost.localdomain>
	 <m17j2gzw5u.fsf@ebiederm.dsl.xmission.com>
	 <1152887287.24925.22.camel@localhost.localdomain>
	 <m17j2gw76o.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 09:35:51 -0700
Message-Id: <1152894951.24925.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 09:13 -0600, Eric W. Biederman wrote:
> Already mentioned but.  rw permissions on sensitive files are for 
> uid == 0.  No capability checks are performed. 

I'd also like to point out that we can do this whole process very
incrementally.  If we want, we can start out with all containers
chroot'd into a filesystem namespace which uses read-only bind mounts
and doesn't allow any write access to the underlying filesystem.

As we introduce the capability checks, we can start to actually
cooperatively share more data.

-- Dave

