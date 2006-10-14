Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752013AbWJNAD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbWJNAD5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 20:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbWJNAD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 20:03:57 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55239 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1752013AbWJNAD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 20:03:56 -0400
Subject: Re: Can context switches be faster?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       John Richard Moser <nigelenki@comcast.net>,
       Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20061013233238.GA6038@rhlx01.fht-esslingen.de>
References: <452E62F8.5010402@comcast.net> <452E9E47.8070306@nortel.com>
	 <452EA441.6070703@comcast.net> <452EA700.9060009@goop.org>
	 <20061013233238.GA6038@rhlx01.fht-esslingen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 14 Oct 2006 01:30:12 +0100
Message-Id: <1160785812.25218.99.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-10-14 am 01:32 +0200, ysgrifennodd Andreas Mohr:
> OK, so since we've now amply worked out in this thread that TLB/cache flushing
> is a real problem for context switching management, would it be possible to
> smartly reorder processes on the runqueue (probably works best with many active
> processes with the same/similar priority on the runqueue!) to minimize
> TLB flushing needs due to less mm context differences of adjacently scheduled
> processes?

We already do. The newer x86 processors also have TLB tagging so they
can (if you find one without errata!) avoid the actual flush and instead
track the tag.

Alan
