Return-Path: <linux-kernel-owner+w=401wt.eu-S1030407AbWLTWfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030407AbWLTWfS (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 17:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030406AbWLTWfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 17:35:18 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:22737 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030405AbWLTWfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 17:35:16 -0500
To: Junio C Hamano <junkio@cox.net>
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] daemon.c blows up on OSX
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	<86vek6z0k2.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
	<86irg6yzt1.fsf_-_@blue.stonehenge.com>
	<7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net>
x-mayan-date: Long count = 12.19.13.16.7; tzolkin = 8 Manik; haab = 0 Kankin
From: merlyn@stonehenge.com (Randal L. Schwartz)
Date: 20 Dec 2006 14:35:12 -0800
In-Reply-To: <7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net>
Message-ID: <86ejquyz4v.fsf@blue.stonehenge.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> merlyn@stonehenge.com (Randal L. Schwartz) writes:
>> Nope... can't compile:
>> ...
>> daemon.c:970: warning: implicit declaration of function 'initgroups'
>> make: *** [daemon.o] Error 1
>> 
>> This smells like we've seen this before.  Regression introduced with
>> some of the cleanup?

Junio> Most likely.  You were CC'ed on these messages:

Junio> 	<7v7iwnnzed.fsf@assigned-by-dhcp.cox.net>
Junio> 	<7vbqlye2zz.fsf@assigned-by-dhcp.cox.net>

I see in 979e32fa1483a32faa4ec331e29b357e5eb5ef25 that I had to change
some things for OpenBSD... I bet those are generic BSD things.

Lemme see if it breaks on OpenBSD as well.

Oddly enough - it didn't. :)

running "git version 1.4.4.3.g5485" on my openbsd box, but I can't get
there on my OSX box.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
