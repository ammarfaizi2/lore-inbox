Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbWGHCvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbWGHCvy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 22:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWGHCvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 22:51:54 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:29089 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932493AbWGHCvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 22:51:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=XVWHZqQELDGZEntLuQhgRB6BJshQ48pab/RMI89U+cWum7mAhNxbxJEMzIydKgBmv9uWhDXZStL35cR7w6Gd7bPRNUzwSWa0RMB4N8Kj3NpmDJMW6yeRmiNB0FTS8vGAjhDLwwotpNgbcuiH3guJFAdwjpWAlYzuk5NiqQNVykA=
Message-ID: <12c511ca0607071951p4fe7e1bfm7be5ad48ede895f1@mail.gmail.com>
Date: Fri, 7 Jul 2006 19:51:52 -0700
From: "Tony Luck" <tony.luck@intel.com>
To: "Jeremy Higdon" <jeremy@sgi.com>
Subject: Re: [PATCH] ia64: change usermode HZ to 250
Cc: "Arjan van de Ven" <arjan@infradead.org>, "Jes Sorensen" <jes@sgi.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "John Daiker" <jdaiker@osdl.org>,
       "John Hawkes" <hawkes@sgi.com>, "Andrew Morton" <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Jack Steiner" <steiner@sgi.com>, "Dan Higgins" <djh@sgi.com>
In-Reply-To: <20060708001427.GA723842@sgi.com>
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
X-Google-Sender-Auth: 9c89f44541a6b0ed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So does i386 convert the return value of the times(2) call to user
> hertz?  On IA64, it returns the value in internal clock ticks, and
> then when a program uses the value in param.h, it gets it wrong now,
> because internal HZ is now 250.
>
> So is times() is broken in IA64, or is this an exception to Alan's
> statement?

The Linux man page for times(2) specifically says "ticks" and refers
to sysconf for how to determine how long a "tick" is.  So ia64 matches
the man page.  Dunno if that matches POSIX though.

-Tony
