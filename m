Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbUCJI1Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 03:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbUCJI1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 03:27:24 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:61960 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262555AbUCJI1U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 03:27:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Redirection of STDERR
Date: Wed, 10 Mar 2004 10:21:36 +0200
X-Mailer: KMail [version 1.4]
References: <20040308111349.030feea6.Christoph.Pleger@uni-dortmund.de> <jehdwylz0x.fsf@sykes.suse.de> <20040310085039.6c234fbc.Christoph.Pleger@uni-dortmund.de>
In-Reply-To: <20040310085039.6c234fbc.Christoph.Pleger@uni-dortmund.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200403101021.36507.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 March 2004 09:50, Christoph Pleger wrote:
> Hello,
>
> > >> In my initialization scripts for hotplug (written for bash) the
> > >> following command is used to redirect output which normally goes to
> > >> stderr to the system logger:
> > >> "exec 2> >(logger -t $0[$$])"
> > >
> > > I don't remember this syntax as legal.
> >
> > That's the process substitution feature of bash, quite handy when you
> > want to get an fd connected to a pipe.
>
> I found out that the problem exists with bash 2.05b, but not with 2.05a.
> The reason is that with 2.05a the command uses the file descriptors
> under /dev/fd0 for the pipe, but with 2.05b the command creates a pipe
> under /tmp. Obviously, the 2.05b mechanism worked with Kernel 2.4, but
> not with 2.6.

I always wondered what prevents bash from NOT using
pipes in the filesystem. It does not use them for
ps | less 
and friends.
-- 
vda
