Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271068AbRHXKe2>; Fri, 24 Aug 2001 06:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271055AbRHXKeS>; Fri, 24 Aug 2001 06:34:18 -0400
Received: from mailf.telia.com ([194.22.194.25]:51155 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S271068AbRHXKeO>;
	Fri, 24 Aug 2001 06:34:14 -0400
Message-Id: <200108241034.f7OAYPA07047@mailf.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: Upd: [PATCH NG] alloc_pages_limit & pages_min
Date: Fri, 24 Aug 2001 12:28:13 +0200
X-Mailer: KMail [version 1.3]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0108231600020.31410-100000@duckman.distro.conectiva> <200108231933.f7NJX8j21551@mailc.telia.com> <20010824112520.5f01626f.skraw@ithnet.com>
In-Reply-To: <20010824112520.5f01626f.skraw@ithnet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fridayen den 24 August 2001 11:25, Stephan von Krawczynski wrote:
> On Thu, 23 Aug 2001 21:28:44 +0200
>
> Roger Larsson <roger.larsson@norran.net> wrote:
> > Riel convinced be to back off a part of the patch.
> > Here comes an updated one.
>
> Hello Roger,
>
> this does not solve my problem with NFS-copies. Just for information. I
> tried and did not work. Besides I expected the patch to make the free pages
> pool somehow bigger during file-copies, but ended up with this situation:
>
> [snip]
>
> The MemFree isn't really a lot compared to inact_dirty. knfsd fails at
> least.

Wait a minute - knfsd... hmm...
Suppose knfsd allock without the wait flag - then it could cause this problems
by itself...

> Aug 21 20:14:51 admin kernel: __alloc_pages: 3-order allocation failed 
> (gfp=0x20/0).

Who is doing thise allocs?
Add a printout of current->pid with format %d
I bet it is knfsd itself (or a driver it uses).

Another thing to try is to run with non kernel nfs...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
