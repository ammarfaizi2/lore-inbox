Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130685AbQLLCB0>; Mon, 11 Dec 2000 21:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129846AbQLLCBQ>; Mon, 11 Dec 2000 21:01:16 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:45116 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129552AbQLLCBF>; Mon, 11 Dec 2000 21:01:05 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: georgn@somanetworks.com
cc: linux-kernel@vger.kernel.org, greg@wind.enjellic.com, sct@redhat.com,
        Linus Torvalds <torvalds@transmeta.com>,
        "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: linux-2.4.0-test11 and sysklogd-1.3-31 
In-Reply-To: Your message of "Mon, 11 Dec 2000 20:13:46 CDT."
             <14901.31690.961664.201896@somanetworks.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 12 Dec 2000 12:30:00 +1100
Message-ID: <3586.976584600@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2000 20:13:46 -0500 (EST), 
"Georg Nikodym" <georgn@somanetworks.com> wrote:
>Here's a patch (against sysklogd-1.3-31) that completely tear out the
>symbol processing code.

Looks good, except that you need to keep the option flags for backwards
compatibility.  There are a *lot* of scripts out there which invoke
klogd with various options and they will fail with this change.  It is
OK to issue a warning message "klogd options -[iIpkx] are no longer
supported" as long as klogd continues to run.  Otherwise you will get a
lot of irate users complaining that klogd is failing at boot time.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
