Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263691AbTJCRc7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 13:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbTJCRc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 13:32:58 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:38156 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263725AbTJCRc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 13:32:57 -0400
Date: Fri, 3 Oct 2003 19:32:51 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andries.Brouwer@cwi.nl, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linuxabi
Message-ID: <20031003173251.GA2097@mars.ravnborg.org>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Andries.Brouwer@cwi.nl, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <UTC200310010001.h9101NU17078.aeb@smtp.cwi.nl> <m17k3nhfex.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m17k3nhfex.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 02, 2003 at 08:39:50AM -0600, Eric W. Biederman wrote:
> So all of the definitions exported
> through linuxabi need to be in a linux centric namespace.

What we try to achieve is to use the same headerfiles for user,
and kernel. Previously this has been done by including selected
files direct from include/linux/*.
A few cases that I recall is DVB, scsi, and ipv6.
For all of these there were no need to create a specific linux namespace.
If there is parts of the kernel that _really_ require a separate
linux namespace then we need to find a solution for that part.
But we should not try to uglify the interface becasue a limited
part of the kernel interface have specific needs.

And since dvb, scsi and ipv6 could accept current namespace before,
they should also be able to accept it today - no?

The concept introduced by inventing abi/ is to make it visible
what part of the kernel interface is actually visible from user level.
And also a good way for us to make sure no kernel specific types sneaks in.

	Sam
