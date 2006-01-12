Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161323AbWALVqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161323AbWALVqf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 16:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161321AbWALVqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 16:46:34 -0500
Received: from mail.dvmed.net ([216.237.124.58]:62179 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161311AbWALVqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 16:46:33 -0500
Message-ID: <43C6CE1D.80804@pobox.com>
Date: Thu, 12 Jan 2006 16:46:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kumar Gala <galak@gate.crashing.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: git pull request email's
References: <Pine.LNX.4.44.0601121527220.23584-100000@gate.crashing.org>
In-Reply-To: <Pine.LNX.4.44.0601121527220.23584-100000@gate.crashing.org>
Content-Type: multipart/mixed;
 boundary="------------000405060507040204020903"
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Kumar Gala wrote: > How do you produce the git pull
	request emails that you sent to Linus? I hope you don't mind me
	answering you in public. Attached is the simple script I use to create
	the pull emails. I manually include the emails inside mutt, rather than
	letting the script send the emails directly. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000405060507040204020903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Kumar Gala wrote:
> How do you produce the git pull request emails that you sent to Linus?

I hope you don't mind me answering you in public.

Attached is the simple script I use to create the pull emails.  I 
manually include the emails inside mutt, rather than letting the script 
send the emails directly.

	Jeff



--------------000405060507040204020903
Content-Type: application/x-sh;
 name="mkmsg.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mkmsg.sh"

#!/bin/sh

#
# usage: mkmsg BRANCH OUTPUT-FILE
#

BRANCH="$1"
TEXT_OUT="$2"

PWD=`pwd`
REPO=`basename $PWD`

echo "Please pull from '$BRANCH' branch of" > $TEXT_OUT
echo "master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/$REPO.git" \
	>> $TEXT_OUT
echo "" >> $TEXT_OUT
echo "to receive the following updates:" >> $TEXT_OUT
echo "" >> $TEXT_OUT

git diff master..$BRANCH | diffstat -p1 >> $TEXT_OUT
echo "" >> $TEXT_OUT
git log --no-merges master..$BRANCH | git shortlog >> $TEXT_OUT
git diff master..$BRANCH >> $TEXT_OUT


--------------000405060507040204020903--
