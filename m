Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWAFPm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWAFPm2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 10:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWAFPm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 10:42:28 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:36370 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751169AbWAFPm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 10:42:27 -0500
Date: Fri, 6 Jan 2006 16:41:57 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: .gitignore files really necessary?
Message-ID: <20060106154157.GB7953@mars.ravnborg.org>
References: <20060106022531.GA7152@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106022531.GA7152@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 10:25:31AM +0800, Coywolf Qi Hunt wrote:
> Hello,
> 
> I see you keep updating .gitignore files. That would be a never ending
> extra burden IMHO.  May I suggest we all use KBUILD_OUTPUT instead to keep
> the source tree clean?  Or am I missing you?

You will see a number of .gitignore updates until we get the kernel
covered as is. After that the .gitignore files will seldom see updates.

Also some of the patches even change things already to simplify stuff.
Look at last patch from Brian that ignores *.so in all the trees - this
covers all the architectures using vdso tricks.

And the typical developer does not want to use KBUILD_OUTPUT, that would
be cumbersome when debugging the kernel - so requesting all users to
start using KBUILD_OUTPUT (make O=...) is not an option.

	Sam
