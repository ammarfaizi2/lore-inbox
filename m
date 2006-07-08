Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWGHNH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWGHNH0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 09:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWGHNHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 09:07:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:28801 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964819AbWGHNHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 09:07:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=mZedzrBqJim9pA3KsSYCQG5i6k6pxVg/+lj6WsMHwmIL8RuTUf2NViuYmM8NzN6cWIZmjDZNRXFnHJ/cSSPg/YagrD1x5gJDRJ7hLaA9A6KwpZPpWIErYOKF5zz0RHmCVbMJViLLwm1UKQpZ29Vkv0bFWaObK8TxfTWSZpYYiL0=
Message-ID: <ed5aea430607080607u67aeb05di963243c0e653e4f0@mail.gmail.com>
Date: Sat, 8 Jul 2006 07:07:14 -0600
From: "David Mosberger-Tang" <David.Mosberger@acm.org>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: [PATCH] ia64: change usermode HZ to 250
Cc: "Jeremy Higdon" <jeremy@sgi.com>, "Jes Sorensen" <jes@sgi.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Luck, Tony" <tony.luck@intel.com>, "John Daiker" <jdaiker@osdl.org>,
       "John Hawkes" <hawkes@sgi.com>, "Tony Luck" <tony.luck@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, "Jack Steiner" <steiner@sgi.com>,
       "Dan Higgins" <djh@sgi.com>
In-Reply-To: <1152340963.3120.0.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <617E1C2C70743745A92448908E030B2A27FC5F@scsmsx411.amr.corp.intel.com>
	 <yq04py4i9p7.fsf@jaguar.mkp.net>
	 <1151578928.23785.0.camel@localhost.localdomain>
	 <44A3AFFB.2000203@sgi.com>
	 <1151578513.3122.22.camel@laptopd505.fenrus.org>
	 <20060708001427.GA723842@sgi.com>
	 <1152340963.3120.0.camel@laptopd505.fenrus.org>
X-Google-Sender-Auth: 3c1c9111234111a8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing is broken.  Read Alan's statement carefully...

  --david

On 7/8/06, Arjan van de Ven <arjan@infradead.org> wrote:
>
>
> > So does i386 convert the return value of the times(2) call to user
> > hertz?  On IA64, it returns the value in internal clock ticks, and
> > then when a program uses the value in param.h, it gets it wrong now,
> > because internal HZ is now 250.
> >
> > So is times() is broken in IA64, or is this an exception to Alan's
> > statement?
>
> yes it's broken; it needs to convert it to the original HZ (1024) and
> make the sysconf() function also return 1024
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Mosberger Consulting LLC, http://www.mosberger-consulting.com/
