Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261513AbTCKSPA>; Tue, 11 Mar 2003 13:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261515AbTCKSPA>; Tue, 11 Mar 2003 13:15:00 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:9615 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261513AbTCKSO7>; Tue, 11 Mar 2003 13:14:59 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 11 Mar 2003 10:34:46 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Giuliano Pochini <pochini@shiny.it>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [patch, rfc] lt-epoll ( level triggered epoll ) ...
In-Reply-To: <XFMail.20030311171056.pochini@shiny.it>
Message-ID: <Pine.LNX.4.50.0303111028370.1855-100000@blue1.dev.mcafeelabs.com>
References: <XFMail.20030311171056.pochini@shiny.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Mar 2003, Giuliano Pochini wrote:

>
> On 10-Mar-2003 Davide Libenzi wrote:
> >
> > During the last three months I spent considerable amount of time explainig
> > developers how edge triggered APIs works, and how to use epoll inside
> > their apps. It's time for me to face the reality, that is that:
> >
> > 1) developers not quite understand ET APIs
> > 2) most existing apps are written using LT APIs
>
> 1) is easily solvable writing a good FAQ. "Developers" who really
> can't undestand edge triggered APIs will continue to use poll().
> If ET il faster than LT, tell people to stop whining and to learn
> the API. Otherwise choose LT, mainly because of 2), but also
> because ET API is more subtle bug prone.

Believe me, many don't understand ET APIs. The epoll(4) man page tries to
answer to many questions but still it's not easy to wipe LT behaviour from
developers brain. On the other side, the merging of epoll inside the
kernel will have to have the goal to be actually and actively used by
developers. Due to the initial epoll architecture it was extremely easy to
have LT epoll and, right now, it has almost no cost to support both
behaviours. My current thought is to have the epoll user to choose the
behaviour on a per-fd basis, using a new EPOLLET event flag. I'm obviously
open to better suggestions ...




- Davide

