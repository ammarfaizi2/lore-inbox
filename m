Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268511AbRHGPqa>; Tue, 7 Aug 2001 11:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268940AbRHGPqU>; Tue, 7 Aug 2001 11:46:20 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:56331 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S268838AbRHGPqP>; Tue, 7 Aug 2001 11:46:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [RFC] using writepage to start io
Date: Tue, 7 Aug 2001 17:51:26 +0200
X-Mailer: KMail [version 1.2]
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
        "Stephen C. Tweedie" <sct@redhat.com>, Chris Mason <mason@suse.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <01080623182601.01864@starship> <01080715292606.02365@starship> <20010807152318.H4036@redhat.com>
In-Reply-To: <20010807152318.H4036@redhat.com>
MIME-Version: 1.0
Message-Id: <01080717512607.02365@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 August 2001 16:23, Stephen C. Tweedie wrote:
> Hi,
>
> On Tue, Aug 07, 2001 at 03:29:26PM +0200, Daniel Phillips wrote:
> >   Ext3 has its own writeback daemon
>
> Ext3 has a daemon to schedule commits to the journal, but it uses the
> normal IO scheduler for unforced writebacks.

Yes.  The currently favored journalling mode uses a writeback journal,
no?  In other words the ext3 journal daemon seems to fit the description
pretty well, especially if you have several of them on one disk.

--
Daniel
