Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbTJOK1l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 06:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbTJOK13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 06:27:29 -0400
Received: from smtp2.att.ne.jp ([165.76.15.138]:16380 "EHLO smtp2.att.ne.jp")
	by vger.kernel.org with ESMTP id S262543AbTJOK0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 06:26:15 -0400
Message-ID: <00ed01c39306$b0277a90$3eee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Hans Reiser" <reiser@namesys.com>, "Wes Janzen" <superchkn@sbcglobal.net>
Cc: "Rogier Wolff" <R.E.Wolff@BitWizard.nl>,
       "John Bradford" <john@grabjohn.com>, <linux-kernel@vger.kernel.org>,
       <nikita@namesys.com>
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60> <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk> <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60> <20031014064925.GA12342@bitwizard.nl> <3F8BA037.9000705@sbcglobal.net> <3F8BBC08.6030901@namesys.com>
Subject: Re: Why are bad disk sectors numbered strangely, and what happens to them?
Date: Wed, 15 Oct 2003 19:23:37 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:

> I think the problem is that many users don't know how to trigger the bad
> sector remapping for the case where the drive can still remap, using
> writes to the bad blocks, and probably our faq needs updating.

This is indeed one of the problems[*].  The other problem is that it seems
to be absurdly difficult to find which file contains the bad sector.  Even
though a file could have multiple hard links, it would be enough to get one
pathname for the file, in order to know which file needs to be reconstructed
from a source of good data.

[* Of course I also wish that the original failing write had been detected
by the drive, but this failure isn't software's fault.  I hope.]

