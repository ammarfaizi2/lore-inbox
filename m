Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265198AbSJRPiA>; Fri, 18 Oct 2002 11:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265207AbSJRPiA>; Fri, 18 Oct 2002 11:38:00 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:49168 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S265198AbSJRPh7>;
	Fri, 18 Oct 2002 11:37:59 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Christoph Hellwig <hch@sgi.com>
Cc: John Hesterberg <jh@sgi.com>, linux-kernel@vger.kernel.org,
       Robin Holt <holt@sgi.com>
Subject: Re: [PATCH] 2.5.43 CSA, Job, and PAGG 
In-reply-to: Your message of "Fri, 18 Oct 2002 18:00:31 -0400."
             <20021018180031.A27391@sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 19 Oct 2002 01:43:48 +1000
Message-ID: <29929.1034955828@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2002 18:00:31 -0400, 
Christoph Hellwig <hch@sgi.com> wrote:
>On Sat, Oct 19, 2002 at 12:37:50AM +1000, Keith Owens wrote:
>> The construct #if defined(CONFIG_FOO) || defined(CONFIG_FOO_MODULE) is
>> required for all CONFIG_FOO which can be defined as tristate.
>
>Keith, I know that it works.  Which doesn't make it a good idea.

With the current config system you have to code that way if FOO can be
built in or a module.  What do you mean by this?

>> On Thu, 17 Oct 2002 22:44:10 -0400, 
>> Christoph Hellwig <hch@sgi.com> wrote:
>> >+#if defined (CONFIG_CSA_JOB_ACCT) || defined (CONFIG_CSA_JOB_ACCT_MODULE)
>> >Umm, stubbing stuff out based on _MODULE is a bad, bad idea.  Just make it
>> >a bool instead.

With
  dep_tristate '    CSA Job Accounting' CONFIG_CSA_JOB_ACCT $CONFIG_PAGG_JOB
there is no single bool which defines if CONFIG_CSA_JOB_ACCT is set or
not in .config.

There is even source code that needs to know if CONFIG_FOO was set to y
or m, that code needs the existing separation between CONFIG_FOO and
CONFIG_FOO_MODULE.

