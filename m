Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278701AbRK1SDr>; Wed, 28 Nov 2001 13:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272818AbRK1SDh>; Wed, 28 Nov 2001 13:03:37 -0500
Received: from c38889-c.grlnd1.tx.home.com ([24.4.38.23]:4994 "HELO
	webby.quo.to") by vger.kernel.org with SMTP id <S278701AbRK1SDX>;
	Wed, 28 Nov 2001 13:03:23 -0500
Message-ID: <000901c17836$f6a88190$024d460a@neptune>
From: "Jordan Russell" <jr-list-kernel@quo.to>
To: "Giuliano Pochini" <pochini@shiny.it>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <XFMail.20011128163916.pochini@shiny.it>
Subject: Re: Small security bug with misconfigured access rights
Date: Wed, 28 Nov 2001 12:03:20 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuliano Pochini wrote:
> Well, I don't know if it is really a bug.
>
> Create a directory like this:
>
> # ls -la
> total 12
> drwxr-sr-x   2 pochini  root         4096 Nov 28 16:33 .
> drwxr-xr-x  32 pochini  users        8192 Nov 28 16:25 ..
>
> Sgid bit is set and the directory is owned by me and the
> group is root (yes, it shouldn't be).
>
> When I create a file here, it gets the root group even
> if I don't belong to it.

That's the correct behavior. Quoting "man mount":

       grpid or bsdgroups / nogrpid or sysvgroups
              These options define what group id a newly  created  file
gets.   When
              grpid  is  set,  it  takes the group id of the directory in
which it is
              created; otherwise (the default) it takes the fsgid of the
current pro-
              cess,  unless  the  directory  has the setgid bit set, in
which case it
              takes the gid from the parent directory, and also gets the
setgid  bit
              set if it is a directory itself.


Jordan Russell

