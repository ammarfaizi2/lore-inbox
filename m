Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161042AbWHJHo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042AbWHJHo6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 03:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbWHJHo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 03:44:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:6090 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161042AbWHJHo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 03:44:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WTtQW3Zlu0HkIqg2Ob9tP/ExoYLXrWoPPIc+a/+7CmvkUDJLwg8MF0yvLSetEIEIWP26V9vG0ksVDFqizOw91PaXBoEd7W1qwZ+D/qmSCzNSxC2bV1qN7tlYV5CkwDXSuMfhP94OAsJQO8Jp8gG8XhurjvdWVFynKGYndu9DhqQ=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: "Molle Bestefich" <molle.bestefich@gmail.com>
Subject: Re: ext3 corruption
Date: Thu, 10 Aug 2006 09:44:27 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com> <Pine.LNX.4.61.0608090723520.30551@chaos.analogic.com> <62b0912f0608090822n2d0c44c4uc33b5b1db00e9d33@mail.gmail.com>
In-Reply-To: <62b0912f0608090822n2d0c44c4uc33b5b1db00e9d33@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608100944.27396.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 August 2006 17:22, Molle Bestefich wrote:
> The hardware works flawlessly.
> The shutdown was a regular shutdown -h.
> 
> Messages on the console indicated that Linux actually tried to
> shutdown the filesystem before shutting down Samba, which is just
> plain Real-F......-Stupid.  Is there no intelligent ordering of
> shutdown events in Linux at all?

There is no shutdown ordering in the Linux *kernel*, it is
the responsibility of the userspace to arrange for that.
IOW: the distribution packagers should do it,
or you, if you maintain your custom-configured system.

> Samba was serving files to remote computers and had no desire to let
> go of the filesystem while still running.  After 5 seconds or so,

Somebody forgot to add a kill -9 to the shutdown scripts.

> Linux just shutdown the MD device with the filesystem still mounted.
> 
> That's what happened on a user-visible level, but what could have
> happened internally in the filesystem?
--
vda
