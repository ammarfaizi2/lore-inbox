Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290831AbSARV1l>; Fri, 18 Jan 2002 16:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290836AbSARV1b>; Fri, 18 Jan 2002 16:27:31 -0500
Received: from AMontpellier-201-1-6-45.abo.wanadoo.fr ([80.13.220.45]:23819
	"EHLO awak") by vger.kernel.org with ESMTP id <S290830AbSARV1W>;
	Fri, 18 Jan 2002 16:27:22 -0500
Subject: Re: rm-ing files with open file descriptors
From: Xavier Bestel <xavier.bestel@free.fr>
To: lathi@seapine.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <87lmevjrep.fsf@localhost.localdomain>
In-Reply-To: <87lmevjrep.fsf@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 18 Jan 2002 22:27:01 +0100
Message-Id: <1011389222.1203.3.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-01-18 at 22:11, Doug Alcorn wrote:
> test it[1].  Sure enough, you can rm a file that has opened file
> descriptors and no errors are generated.  Interestingly, sun solaris
> does the same thing.  Since this is the case, I thought this might be
> a feature instead of a bug (ms-win doesn't allow the rm).  So, my
> question is where is this behavior defined?  Is it a kernel issue?

It is defined, and even sometimes used to allocate temporary disk space
(open a file, rm it, you can still r/w your file descriptor and all will
return to free space once your app closes the fd or dies).

	Xav

