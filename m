Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135256AbRDLTCM>; Thu, 12 Apr 2001 15:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135259AbRDLTCD>; Thu, 12 Apr 2001 15:02:03 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:21390 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S135258AbRDLTB6>; Thu, 12 Apr 2001 15:01:58 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 12 Apr 2001 12:01:55 -0700
Message-Id: <200104121901.MAA04011@adam.yggdrasil.com>
To: johan.adolfsson@axis.com
Subject: Re: List of all-zero .data variables in linux-2.4.3 available
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

johan.adolfsson@axis.com writes:
>Shouldn't a compiler be able to deal with this instead?

	Yes.  I sent some email to bug-gcc about this a couple of
months ago and even posted some (probably horribly incorrect) code
showing roughly the change I had in mind in the gcc source code
for the simple case of scalar variables.  I was told that some code
to this was put in and then removed from gcc a long time ago, and
nobody seemed interested in putting it back in.  I would think that this
would be a basic optimization that I would expect the compiler to make,
just like deleting "if(0) {......}" code, but gcc does not currently
do that.  If somebody would like to fix gcc and do the necessary
lobbying to get such a change integrated, that would be great.  However,
until that actually happens, I hope the file that I posted to
ftp://ftp.yggdrasil.com/private/adam/linux/zerovars/ will be useful
to individual maintainers and in identifying the largest arrays of
zeroes that can fix fixed in a few lines.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
