Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279170AbRKFMzq>; Tue, 6 Nov 2001 07:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277782AbRKFMzh>; Tue, 6 Nov 2001 07:55:37 -0500
Received: from gap.cco.caltech.edu ([131.215.139.43]:46248 "EHLO
	gap.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S279156AbRKFMzb> convert rfc822-to-8bit; Tue, 6 Nov 2001 07:55:31 -0500
Message-Id: <sbe793a0.089@mail-01.med.umich.edu>
X-Mailer: Novell GroupWise Internet Agent 6.0
Date: Tue, 06 Nov 2001 07:38:49 -0500
From: "Nicholas Berry" <nikberry@med.umich.edu>
To: <terje.eggestad@scali.no>, <amon@vnl.com>
Cc: <weixl@caltech.edu>, <mlist-linux-kernel@nntp-server.caltech.edu>
Subject: Re: How can I know the number of current users in the system?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It depends whether you're looking for an idea of who's on, or you want a definitive count. The lattter is basically almost impossible. What if a logged-in user nohups two xterms to different X-servers, then logs out - how many people are logged in? I've spent a hell of a long time working on this on AIX for a certain German bank, and the bottom line is that it can't be done. What is 'logged on' anyway? Someone running bash or ksh, that's cool, but what about someone running /home/fred/myprog? Is it a shell?

Basically once Unix went beyond serial terminals connected to dumb serial ports, we lost the ability to track users.

Nik


> Hmmm, you should be able to count the number of pty's and tty's.
> Every logged in user is attached to some sort of getty
> whose parent is the init task (1). That might be a basis for
> a count.


