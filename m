Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVDRUiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVDRUiV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 16:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVDRUiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 16:38:21 -0400
Received: from manson.clss.net ([65.211.158.2]:51403 "HELO manson.clss.net")
	by vger.kernel.org with SMTP id S261161AbVDRUiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 16:38:19 -0400
Message-ID: <20050418203818.22843.qmail@manson.clss.net>
From: "Alan Curry" <pacman-kernel@manson.clss.net>
Subject: Re: [PATCH 3/7] procfs privacy: misc. entries
To: davej@redhat.com (Dave Jones)
Date: Mon, 18 Apr 2005 15:38:18 -0500 (EST)
Cc: lorenzo@gnu.org (Lorenzo =?iso-8859-1?Q?Hern=E1ndez_Garc=EDa-Hierro?=),
       linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <20050418190552.GA26322@redhat.com> from "Dave Jones" at Apr 18, 2005 03:05:52 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones writes the following:
>
>On Mon, Apr 18, 2005 at 08:46:52PM +0200, Lorenzo Hernández García-Hierro wrote:
> > This patch changes the permissions of the following procfs entries to
> > restrict non-root users from accessing them:

[snip]
> >  - /proc/uptime
       ^^^^^^^^^^^^ ?!
[snip]

> >  - /proc/cpuinfo
>
>This is utterly absurd. You can find out anything thats in /proc/cpuinfo
>by calling cpuid instructions yourself.

Also it's the backend of glibc's get_nprocs(), also known as
sysconf(_SC_NPROCESSORS_ONLN), a documented interface whose users are
probably not expecting it to suddenly become restricted to root.

>Please enlighten me as to what security gains we achieve
>by not allowing users to see this ?
>
>Restricting lots of the other files are equally absurd.
>
>I'd also be very surprised if various random bits of userspace
>broke subtley due to this nonsense.

Like uptime(1), a command which has existed basically unchanged since 3.0BSD
(note to observers: if you think that's a funny way of writing "FreeBSD 3.0",
you're off by at least a decade and a half).

