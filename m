Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277630AbRJLLoM>; Fri, 12 Oct 2001 07:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277636AbRJLLoB>; Fri, 12 Oct 2001 07:44:01 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:29171 "EHLO snfc21.pbi.net")
	by vger.kernel.org with ESMTP id <S277630AbRJLLnw>;
	Fri, 12 Oct 2001 07:43:52 -0400
Date: Fri, 12 Oct 2001 00:31:24 -0700 (PDT)
From: Chris Rankin <rankinc@pacbell.net>
Subject: Password prompt sometime appears on wrong vc???
To: linux-kernel@vger.kernel.org
Message-id: <200110120731.f9C7VOxX015524@twopit.underworld>
MIME-version: 1.0
X-Mailer: ELM [version 2.5 PL6]
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been noticing this problem for several kernel iterations now;
before 2.4.7, I think. Basically, the *first* time that I try to login
to a vc (my non-X console is vc/6), the "login: " prompt appears on
vc/6 but the "Password:" prompt always appears on vc/1. I have to type
the password in on vc/1 as well. This happens on both my UP non-devfs
box and on my SMP devfs box.

Once I logout and try logging in again, the "Password:" prompt appears
correctly on vc/6 and everything is fine.

I am using the shadow utilities, and so the password is read from
/dev/tty rather than from /dev/vc/6. However, my understanding is that
/dev/tty is meant to be the "current" console. Is something failing to
get initialised somewhere?

Cheers,
Chris
