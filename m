Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWAaVEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWAaVEW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 16:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWAaVEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 16:04:22 -0500
Received: from dslsmtp.struer.net ([62.242.36.21]:16146 "EHLO
	dslsmtp.struer.net") by vger.kernel.org with ESMTP id S1751490AbWAaVEU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 16:04:20 -0500
Message-ID: <29639.194.237.142.10.1138741459.squirrel@194.237.142.10>
In-Reply-To: <1138738320.6424.37.camel@localhost.localdomain>
References: <11368427243850@foobar.com>
    <1138738320.6424.37.camel@localhost.localdomain>
Date: Tue, 31 Jan 2006 22:04:19 +0100 (CET)
Subject: Re: [PATCH 09/11] kbuild: drop vmlinux dependency from 'make 
     install'
From: "Sam Ravnborg" <sam@ravnborg.org>
To: "Dave Hansen" <haveblue@us.ibm.com>
Cc: "Sam Ravnborg" <sam@ravnborg.org>, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2006-01-09 at 22:38 +0100, Sam Ravnborg wrote:
>> This removes the dependency from vmlinux to install, thus avoiding the
>> current situation where "make install" has a nasty tendency to leave
>> root-turds in the working directory.
>
> One minor issue I've noticed with this is that I have script that do:
>
> 	make -j8 vmlinux install
>
> Without the dependency, I think the install is done in parallel, and
> doesn't get the result of that build.
Correct. All targets on the commandline are evaluated in parallel.

>  Is there a way I can accomplish
> the same thing with one make command with the new dependency?
No - unfortunately not.

Oh, you may restrict yourself to UP and use make -j1 but that would be
a workaround ;-)

    Sam

