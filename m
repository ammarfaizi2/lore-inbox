Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbVDOUUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVDOUUJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 16:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbVDOUUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 16:20:09 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:49107 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261874AbVDOUUD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 16:20:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iMT7ITGeZ9PSxOnZDuAQrJ1lDmsjXNor99/9nL6uczqKYrujxPmoipof5pnIKnr6zehDFNBEgdw2/BKDtCV7MrLfXC9VhJKmcVS/7/Pg5DlXsJ/zVFqoNRkBLcpNhabdFolrOHOZbJmhUZE6fOCtdtJAJ/EE2DxsPQGiWrzfxUA=
Message-ID: <e1e1d5f4050415131977a776e9@mail.gmail.com>
Date: Fri, 15 Apr 2005 13:19:55 -0700
From: Daniel Souza <thehazard@gmail.com>
Reply-To: Daniel Souza <thehazard@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: intercepting syscalls
Cc: Igor Shmukler <igor.shmukler@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1113596014.6694.87.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6533c1c905041511041b846967@mail.gmail.com>
	 <1113588694.6694.75.camel@laptopd505.fenrus.org>
	 <6533c1c905041512411ec2a8db@mail.gmail.com>
	 <e1e1d5f40504151251617def40@mail.gmail.com>
	 <6533c1c905041512594bb7abb4@mail.gmail.com>
	 <e1e1d5f40504151310467d16bd@mail.gmail.com>
	 <1113596014.6694.87.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/05, Arjan van de Ven <arjan@infradead.org> wrote:
> On Fri, 2005-04-15 at 13:10 -0700, Daniel Souza wrote:
> > You're welcome, Igor. I needed to intercept syscalls in a little
> > project that I were implementing, to keep track of filesystem changes,
> 
> I assume you weren't about tracking file content changing... since you
> can't do that with syscall hijacking.. (that is a common misconception
> by people who came from a MS Windows environment and did things like
> anti virus tools there this way)

No, I was tracking file creations/modifications/attemps of
access/directory creations|modifications/file movings/program
executions with some filter exceptions (avoid logging library loads by
ldd to preserve disk space).

It was a little module that logs file changes and program executions
to syslog (showing owner,pid,ppid,process name, return of
operation,etc), that, used with remote syslog logging to a 'strictly
secure' machine (just receive logs), keep security logs of everything
(like, it was possible to see apache running commands as "ls -la /" or
"ps aux", that, in fact, were signs of intrusion of try of intrusion,
because it's not a usual behavior of httpd. Maybe anyone exploited a
php page to execute arbitrary scripts...)

-- 
# (perl -e "while (1) { print "\x90"; }") | dd of=/dev/evil
