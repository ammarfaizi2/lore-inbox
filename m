Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131569AbQLGXWo>; Thu, 7 Dec 2000 18:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131564AbQLGXWe>; Thu, 7 Dec 2000 18:22:34 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:23570 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131557AbQLGXWW>;
	Thu, 7 Dec 2000 18:22:22 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: georgn@somanetworks.com
cc: linux-kernel@vger.kernel.org, greg@wind.enjellic.com, sct@redhat.com
Subject: Re: linux-2.4.0-test11 and sysklogd-1.3-31 
In-Reply-To: Your message of "Thu, 07 Dec 2000 12:36:01 CDT."
             <14895.51841.431444.405949@somanetworks.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 08 Dec 2000 09:51:48 +1100
Message-ID: <5597.976229508@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000 12:36:01 -0500 (EST), 
"Georg Nikodym" <georgn@somanetworks.com> wrote:
>>>>>> "KO" == Keith Owens <kaos@ocs.com.au> writes:
>
> KO> I would prefer to see the oops decoding completely removed from
> KO> klogd.
>
>Since nobody else has weighed in on this issue, I quickly did the
>necessary to effect Keith's suggestion.  What follows is a patch to
>sysklogd-1.3-31 (which after applying, ksym_mod.c can be removed):

You only removed the module symbol handling.  The problem is that the
entire klogd oops handling is out of date and broken.  I recommend
removing all oops processing from klogd, which means that klogd does
not need any symbols nor System.map.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
