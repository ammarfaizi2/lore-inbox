Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270955AbRHOAJD>; Tue, 14 Aug 2001 20:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270957AbRHOAIq>; Tue, 14 Aug 2001 20:08:46 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:54598 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S270954AbRHOAIb>; Tue, 14 Aug 2001 20:08:31 -0400
Date: Wed, 15 Aug 2001 02:08:35 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: thockin@sun.com, linux-kernel@vger.kernel.org
Subject: Re: RFC: poll change
Message-ID: <20010815020835.E4304@athlon.random>
In-Reply-To: <3B79B5F3.C816CBED@sun.com> <20010814.163804.66057702.davem@redhat.com> <3B79BA07.B57634FD@sun.com> <20010814.165320.77058794.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010814.165320.77058794.davem@redhat.com>; from davem@redhat.com on Tue, Aug 14, 2001 at 04:53:20PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2001 at 04:53:20PM -0700, David S. Miller wrote:
> invalid fds.  The behavior is identical both before and after
> your change, so there is no reason to make it.

actually I can see a case where it makes difference: if you sends 1024
entries to poll with the last entry of the array polling for one of the
allocated file descriptors (all previous 1023 entries are negative) and
the last fd allocated is ID 255.

Andrea
