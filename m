Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932732AbWAHSV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932732AbWAHSV7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 13:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932738AbWAHSV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 13:21:58 -0500
Received: from [200.77.213.249] ([200.77.213.249]:19168 "EHLO
	cmas-tj.cablemas.com") by vger.kernel.org with ESMTP
	id S932732AbWAHSVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 13:21:53 -0500
X-Mail-Scanner: Scanned by qSheff 0.8-p3 against viruses and spams (http://www.enderunix.org/qsheff/)
Date: Sun, 8 Jan 2006 10:21:01 -0800
From: Octavio Alvarez Piza <alvarezp@alvarezp.ods.org>
To: gcoady@gmail.com, linux-kernel@vger.kernel.org
Cc: Willy Tarreau <willy@w.ods.org>, Markus Rechberger <mrechberger@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Why is 2.4.32 four times faster than 2.6.14.6??
Message-ID: <20060108102101.770a395f@octavio.alvarezp.pri>
In-Reply-To: <eto1s19q78qg34o5uq37o46t30f3adfn0q@4ax.com>
References: <l6b1s152vo49j7dmthvbhoqej1modrs2k7@4ax.com>
	<d9def9db0601072258v39ac4334kccc843838b436bba@mail.gmail.com>
	<gre1s1lkr687o2npgom26gqq3etgjdjgpo@4ax.com>
	<20060108095741.GH7142@w.ods.org>
	<eto1s19q78qg34o5uq37o46t30f3adfn0q@4ax.com>
Organization: (None)
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 08 Jan 2006 22:05:43 +1100
Grant Coady <gcoady@gmail.com> wrote:

> On Sun, 8 Jan 2006 10:57:41 +0100, Willy Tarreau <willy@w.ods.org> wrote:
> 
> > Could you please retest :
> >  - without the pipe (remove '| cut ...') to avoid inter-process
> >    communications
> 
> I thought it made a difference, then delay back again, I'll try 
> again tomorrow when I'm more awake.
> 
> >You should be able to find one simple pattern which makes the problem
> >appear/disappear on 2.6. At least, 'cat x.log >/dev/null' should not
> >take time or that time should be spent in I/O.
> 
> Yes, done that and the time went down by ~five seconds.

Just make sure you first read all the file with cat (I'd retry all from
the initial tests) so you don't add hd-read time to the first command.

Octavio.
