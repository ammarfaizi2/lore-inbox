Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbUCaR6M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 12:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbUCaR6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 12:58:12 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:5291 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S262008AbUCaR6J convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 12:58:09 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Greg Kroah-Hartman <greg@kroah.com>
Subject: Re: [PATCH] s390 (8/10): zfcp fixes
Date: Wed, 31 Mar 2004 19:57:18 +0200
X-Mailer: KMail [version 1.4]
Cc: schwidefsky@de.ibm.com, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200403311957.18451.heiko.carstens@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

>> I'll ask because the zfcp patches are still pending and I want to get this
>> issue resolved before the next try to get them integrated.
>I think you need to talk to the scsi people, as kfree() should _never_
>need to be set as the release function. There's something just wrong
>with the design if that is necessary.

Actually this issue is not SCSI related, but a generic problem that one
can run into when fiddling around with modules / module unloading.

This was already discussed elsewhere. Please have a look here:

http://lwn.net/Articles/67421/
(paragraph "Module unloading in a reference counted world")

and here for the whole thread:

http://www.ussg.iu.edu/hypermail/linux/kernel/0401.2/1832.html
(just saw that you participated there :)

I would be more than happy to have a nice release function for the zfcp
generated objects, but I don't think this is currently possible without
having the potential problem to run into an Oops after module unloading.

Heiko

