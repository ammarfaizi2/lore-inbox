Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136357AbRAHB1U>; Sun, 7 Jan 2001 20:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136445AbRAHB1J>; Sun, 7 Jan 2001 20:27:09 -0500
Received: from runyon.cygnus.com ([205.180.230.5]:33671 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S136357AbRAHB04>;
	Sun, 7 Jan 2001 20:26:56 -0500
To: Keith Owens <kaos@ocs.com.au>
Cc: Matthias Juchem <juchem@uni-mannheim.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new bug report script
In-Reply-To: <8673.978913442@ocs3.ocs-net>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
From: Ulrich Drepper <drepper@redhat.com>
Date: 07 Jan 2001 17:26:37 -0800
In-Reply-To: Keith Owens's message of "Mon, 08 Jan 2001 11:24:02 +1100"
Message-ID: <m3n1d27s1e.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> writes:

> 		5)
> 			# glibc versions.  Take the last symbolic link,
> 			# extract the version number from the file it points to.
> 			if [ `expr "X$1" : 'Xl'` -eq 2 ]
> 			then
> 				while [ "X$2" != "X->" ]
> 				do
> 					shift
> 				done
> 				version2=`echo "$3" | tr -cd '[.0-9]' | \
> 					  sed -e 's/\.\.*/./g' |
> 					  sed -e 's/^\.//g' |
> 					  sed -e 's/\.$//g'`
> 			fi
> 			;;

Why don't you, as the other script suggested, execute libc.so.6?
Symlinks can be missing or can be wrong.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
