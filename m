Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263386AbTIBCg7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 22:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbTIBCg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 22:36:59 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:47338 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S263386AbTIBCg6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 22:36:58 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: dontdiff for 2.6.0-test4
cc: linux-kernel@vger.kernel.org
References: <3F53F142.5050909@pobox.com> <Pine.GSO.4.44.0309010754480.1106-100000@north.veritas.com>
 <20030901163958.A24464@infradead.org>
 <20030901162244.GA1041@mars.ravnborg.org> <3F537CDD.3040809@pobox.com>
 <20030901171806.GB1041@mars.ravnborg.org>
From: Junio C Hamano <junkio@cox.net>
Date: Mon, 01 Sep 2003 19:36:56 -0700
In-Reply-To: <fa.ebr1o03.l4o1q3@ifi.uio.no> (Jeff Garzik's message of "Tue,
 2: 25:56 GMT")
Message-ID: <7vk78rykzb.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "JG" == Jeff Garzik <jgarzik@pobox.com> writes:

JG> I stand corrected :)  However, I think it's a tangent:

JG> dontdiff is a file that's useful precisely because of the form its
JG> in. So, as something that's proven itself useful to a bunch of people,
JG> I definitely think it has a home somewhere in Documentation/*  It need
JG> not be referenced in any way by kbuild; that's not a big deal.  The
JG> two really serve different purposes.

I do not think it is a tangent.  While I am not opposed to ship
dontdiff under Documentation/* separately from the current
mrproper implementation in the Makefile, if these two should
name the identical set of paths, coming up with a scheme in
which humans have to maintain just a single source and derive
these two different usage from that single source would make
people's life easier.  Two things that should be identical but
have to be kept in sync by hand is simply a maintenance
headache.

On the other hand, if there are paths that should be in dontdiff
that should not be cleaned by mrprper, or vice versa, then
keeping two separately and maintaining two independently would
absolutely makes sense.  Are there such cases?

