Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264284AbUBEISb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 03:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264361AbUBEISb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 03:18:31 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:63887 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S264284AbUBEIS3
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.Org>);
	Thu, 5 Feb 2004 03:18:29 -0500
From: "Riley Williams" <Riley@Williams.Name>
To: "Bryan Whitehead" <driver@megahappy.net>
Cc: "Linux Kernel Development" <Linux-Kernel@Vger.Kernel.Org>
Subject: Re: [PATCH 2.6.2] Documentation/SubmittingPatches
Date: Thu, 5 Feb 2004 08:18:32 -0000
Message-ID: <BKEGKPICNAKILKJKMHCAOEMFIIAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20040205072303.BCF79FA5F1@mrhankey.megahappy.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bryan.

 > I've been trying to get my feet wet by submitting trivial
 > patches to various maintainers and the responses have been,
 > "you're not submitting you patches correctly". It seems most
 > developers/maintainers want a diff done like this:
 >
 > cd /source-tree
 > diff -u linux-2.6.2/FileToPatch.orig linux-2.6.2/FileToPatch
 >
 > instead of the "SubmitingPatches" document way:
 >
 > cd /source-tree/linux-2.6.2
 > diff -u FileToPatch.orig FileToPatch
 >
 > It would be _great_ if the Documentation was more accurate to
 > the taste of developers/maintainers...

Obviously, I can't speak for the rest of the developers, but my
personal stance has always been this: If I can identify both the
kernel version the patch is against and where in the source tree
is being patched, I will apply the patch. If not, I won't.

I suspect the change you note is due to the number of people who
submit patches within a directory in the source tree that don't
indicate either of the above facts. If the answers aren't obvious
from the email, I run `find -name ${FILE}` from the root directory
of the current source tree and if there's not more than three
possibilities for the file, I will try patching each of them to
see whether the patch will apply to any of them. Beyond that, I
want further information from the submitter.

One other thing I've found useful is to increase the context given
in the diff by using -u5 rather than just -u as that considerably
increases the chances of a successful patch when other patches have
already been applied. However, that's very much personal preference
and probably not shared by other developers.

As an example, if somebody sends me a patch that tweaks a file
called Makefile with no indication of either of the above - well,
let's just say I've better things to do with my time than to
search through the various files of that name in the various
kernel source trees to identify the correct one...

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.576 / Virus Database: 365 - Release Date: 30-Jan-2004

