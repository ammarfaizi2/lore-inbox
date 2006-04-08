Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbWDHXov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWDHXov (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 19:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWDHXov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 19:44:51 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:28307 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1751442AbWDHXou
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 19:44:50 -0400
Subject: Re: [PATCH 3/7] uts namespaces: use init_utsname when appropriate
From: Sam Vilain <sam@vilain.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@sw.ru>, herbert@13thfloor.at, devel@openvz.org,
       xemul@sw.ru, James Morris <jmorris@namei.org>
In-Reply-To: <m1psjslf1s.fsf@ebiederm.dsl.xmission.com>
References: <20060407234815.849357768@sergelap>
	 <20060408045206.EAA8E19B8FF@sergelap.hallyn.com>
	 <m1psjslf1s.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Sun, 09 Apr 2006 11:44:39 +1200
Message-Id: <1144539879.11689.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-08 at 01:09 -0600, Eric W. Biederman wrote:
> > -#define ELF_PLATFORM  (system_utsname.machine)
> > +#define ELF_PLATFORM  (init_utsname()->machine)
> >  
> >  #ifdef __KERNEL__
> >  #define SET_PERSONALITY(ex, ibcs2) do { } while (0)
> I think this one needs to be utsname()->machine.
> Currently it doesn't matter.  But Herbert has expressed
> the desire to make a machine appear like an older one.

This is extremely useful for faking it as "i386" on x86_64 systems, for
instance.

Sam.

