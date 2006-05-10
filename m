Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965029AbWEJVm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbWEJVm0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 17:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbWEJVm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 17:42:26 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:41239 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965029AbWEJVmZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 17:42:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HcDjni8aMUd5JcHgzH+bNnxoN/ObQPpuwKQdh77E/8rVJ0vebAIfnIwUfWBbnieRGgK5tX5aoY0AxrJUGG/T7Okdd7TwVIBi71w0yuysF++OU/wxp2LPyc8MTQvX12iqmHjAqzkWyI7o97zVaxmiQ5airRkvZYTZtUCX6vgmQJI=
Message-ID: <72dbd3150605101442o52a62d79va730314bf96dcfdd@mail.gmail.com>
Date: Wed, 10 May 2006 14:42:24 -0700
From: "David Rees" <drees76@gmail.com>
To: "Mark Hedges" <hedges@ucsd.edu>, linux-kernel@vger.kernel.org
Subject: Re: unknown io writes in 2.6.16
In-Reply-To: <20060510135100.F26270@network.ucsd.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060510135100.F26270@network.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/06, Mark Hedges <hedges@ucsd.edu> wrote:
> I stop every non-kernel process except syslogd, klogd and the
> tty's.  Interfaces are down.  It is still in default runlevel.
> But the disk keeps clicking away.
>
> Any idea what's doing these writes?

It's most likely atime updates. Mount the partitions with noatime
option and your writes will go away.

-Dave
