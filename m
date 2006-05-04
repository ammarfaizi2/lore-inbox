Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751496AbWEDPIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWEDPIH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 11:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWEDPIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 11:08:06 -0400
Received: from wx-out-0102.google.com ([66.249.82.202]:30953 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751496AbWEDPIE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 11:08:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uLBe7R387D0cj6e+jwB6q4QJxDX7sVaumbAA7yrnc3KLlhJEyAviHpSmr0OnNrx/K8u+6Y5BAz8Okn8S8ObXtGE4QwLEjiKC9SBZjs7mp78oyYHB5x/g/eqm3cmvUD+vxdC3iRYss1G51Mleyz4SWX0IK1gq6JPX7aceRwpzeeI=
Message-ID: <afcef88a0605040808s5404b89etf40c95b2967b4f9c@mail.gmail.com>
Date: Thu, 4 May 2006 10:08:03 -0500
From: "Michael Thompson" <michael.craig.thompson@gmail.com>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 5/13: eCryptfs] Header declarations
Cc: "Phillip Hellewell" <phillip@hellewell.homeip.net>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, "James Morris" <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, "Erez Zadok" <ezk@cs.sunysb.edu>,
       "David Howells" <dhowells@redhat.com>
In-Reply-To: <84144f020605040751t2d2dca5ai4044f28d7118ee96@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060504031755.GA28257@hellewell.homeip.net>
	 <20060504033750.GD28613@hellewell.homeip.net>
	 <84144f020605040751t2d2dca5ai4044f28d7118ee96@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> On 5/4/06, Phillip Hellewell <phillip@hellewell.homeip.net> wrote:
> > +
> > +#define ecryptfs_printk(type, fmt, arg...) \
> > +        __ecryptfs_printk(type "%s: " fmt, __FUNCTION__, ## arg);
> > +void __ecryptfs_printk(const char *fmt, ...);
>
> Why not plain printk?

Originally, ecryptfs_printk was using a verbosity level, which is why
there was a custom call wrapping printk. This is no longer the case,
and the eCryptfs developers are currently looking at this, and are
planning to remove the bulk of printks.

Thanks,
Mike

--
Michael C. Thompson <mcthomps@us.ibm.com>
Software-Engineer, IBM LTC Security
