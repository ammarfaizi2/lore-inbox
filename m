Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWDFXd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWDFXd2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 19:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWDFXd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 19:33:28 -0400
Received: from uproxy.gmail.com ([66.249.92.197]:29922 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932233AbWDFXd1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 19:33:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qXepKtzryxbqA8TW7qZdtmecpJmVAeHdBj574cbnYCcgu02F/1z2Lzo1JgK6KZwsHf/2u4GHfeU/Af9t2RBd6tkXuXxMvflEVy3WtTc1FLUcH60NLpOKvAACKqfE1M36nISx9weZvB/Fse1E/9iVlo1Tk28eeTmaCOJJxuplV/M=
Message-ID: <12c511ca0604061633p2fb1796axd5acad8373532834@mail.gmail.com>
Date: Thu, 6 Apr 2006 16:33:23 -0700
From: "Tony Luck" <tony.luck@gmail.com>
To: "Mike Hearn" <mike@plan99.net>
Subject: Re: [PATCH] Add a /proc/self/exedir link
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <44343C25.2000306@plan99.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4431A93A.2010702@plan99.net>
	 <m1fykr3ggb.fsf@ebiederm.dsl.xmission.com>
	 <44343C25.2000306@plan99.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I have concerns about security policy ...
>
> I'm not sure I understand. Only if you run that program, and if you
> don't have access to the intermediate directory, how do you run it?

It leaks information about the parts of the pathname below the
directory that you otherwise would not be able to see.  E.g. if
I have $HOME/top-secret-projects/secret-code-name1/binary
where the top-secret-projects directory isn't readable by you,
then you may find out secret-code-name1 by reading the
/proc/{pid}/exedir symlink.

-Tony
