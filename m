Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263655AbTDISYz (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 14:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263656AbTDISYz (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 14:24:55 -0400
Received: from hera.cwi.nl ([192.16.191.8]:685 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263655AbTDISYy (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 14:24:54 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 9 Apr 2003 20:36:32 +0200 (MEST)
Message-Id: <UTC200304091836.h39IaWE29913.aeb@smtp.cwi.nl>
To: hpa@zytor.com, zippel@linux-m68k.org
Subject: Re: 64-bit kdev_t - just for playing
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Peter and Andries, I would really appreciate it, if
> you would stop ignoring me

But Roman, I answered a dozen of your letters, and
it seems to me that further letters would only
lead to repetition.

Let me recapitulate.

(i) On dev_t
A dev_t is a number. There are three streams:
mknod sends such a number from user space to the file system,
stat sends such a number from the file system to user space,
open and mount send such a number from the file system to the kernel
where the kernel finds an associated device.

Your questions are about the meaning of this number,
that is, about the third part. What I am doing is only
removing certain restrictions on the size of the number.


(ii) On device naming.
One can handle device naming in the old-fashioned way,
as Unix always did, or one can invent one of many possible
schemes for the future.
This old-fashioned way has a myriad of problems, but it works,
people are used to it and know precisely what the problems are,
and our present software handles it.
These schemes of the future are not yet crystallized out very well,
there are several to choose from, we do not yet know very well
what the problems will be, most of the software to handle such
new schemes still has to be written.

[And note that stat is an important system call - even with
new naming schemes we may need numbers - possibly some hash of
whatever ID we have found.]

Clearly, there will be a long transition period where these
schemes will coexist.

Now this old fashioned scheme has run into some limits -
it ran into them already several years ago, witness the
introduction of several scsi disk majors. Removing these limits
is not very difficult, so we do that now.

Your letters carry the tone of "it is forbidden to work on the
old scheme before you have shown how to solve all device naming
problems". But I am not going to.

You have opinions and questions about future schemes.
And so do I. But since time is limited I wrote you
already a handful of times: "Later".

This number stuff is simple and straightforward, we know precisely
what has to be done, but of course it needs to be done.

Naming on the other hand is intricate, lots of complications.
Device naming - but what is a device? Already that is complicated.
These are good discussions, and maybe sysfs will provide the answer
in certain cases, but these discussions are independent of dev_t.

Andries
