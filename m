Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965135AbWDNK5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135AbWDNK5F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 06:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965142AbWDNK5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 06:57:05 -0400
Received: from smtp105.plus.mail.re2.yahoo.com ([206.190.53.30]:48270 "HELO
	smtp105.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S965135AbWDNK5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 06:57:03 -0400
Date: Fri, 14 Apr 2006 12:57:00 +0200
From: <tyler@agat.net>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] Kmod optimization
Message-ID: <20060414105700.GA4153@Starbuck>
Mail-Followup-To: tyler@agat.net, linux-kernel@vger.kernel.org,
	Greg KH <gregkh@suse.de>
References: <20060413180345.GA10910@Starbuck> <20060413182401.GA26885@suse.de> <20060413183617.GB10910@Starbuck> <20060413185014.GA27130@suse.de> <20060413190412.GA30541@Starbuck> <20060413231330.GA6760@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413231330.GA6760@suse.de>
User-Agent: mutt-ng/devel-r782 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 04:13:30PM -0700, Greg KH wrote:
> The kernel will not call out to try to resolve the symbols, that's up to
> userspace to handle.  Hint, try running 'modprobe moduleA.ko' instead,
> it will handle the dependancies correctly.
> 
> I still don't see where this is really needed...
> 
> thanks,
> 
> greg k-h

I meant, the purpose of request_module is to handle dependencies from the
kernel : if we need a functionnality, we request it. It's the definition
of dependency.

But I understood the mechanism by reading some request_module examples.
In fact, we test the avalaibility of the functionnality before calling
the request_module function.

So the case described in my previous message would normally never
happen.

if (!functionnality_not_avalaible) {
	module_request(functionnality)

	if (!functionnality_not_avalaible)
	    goto error;
}

Sorry, so the discussion is closed : forget it :)

-- 
tyler
tyler@agat.net


	

	
		
___________________________________________________________________________ 
Faites de Yahoo! votre page d'accueil sur le web pour retrouver directement vos services préférés : vérifiez vos nouveaux mails, lancez vos recherches et suivez l'actualité en temps réel. 
Rendez-vous sur http://fr.yahoo.com/set
