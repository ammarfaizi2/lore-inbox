Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbSIWUcj>; Mon, 23 Sep 2002 16:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261336AbSIWUcj>; Mon, 23 Sep 2002 16:32:39 -0400
Received: from ccc-static.netway.com ([216.177.12.130]:8973 "HELO ccc.com")
	by vger.kernel.org with SMTP id <S261292AbSIWUci>;
	Mon, 23 Sep 2002 16:32:38 -0400
To: Shailabh Nagar <nagar@watson.ibm.com>
cc: Stephen Hemminger <shemminger@osdl.org>,
       Benjamin LaHaise <bcrl@redhat.com>, Andrew Morton <akpm@digeo.com>,
       Alexander Viro <viro@math.psu.edu>, linux-aio <linux-aio@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
From: "Clement T. Cole" <clemc@alumni.cmu.edu>
Subject: Re: [RFC] adding aio_readv/writev 
Really-From: Clement T. Cole
Organization: President/Owner, Cole Computer Consulting
In-reply-to: Your message of "Mon, 23 Sep 2002 15:52:21 EDT."
             <3D8F70F5.4040406@watson.ibm.com> 
Reply-To: clemc@alumni.cmu.edu
Date: Mon, 23 Sep 2002 16:39:42 -0400
Message-Id: <20020923203238Z261292-8740+66@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>It would have been nice to have corresponding data for the async path.
Agreed... I'll let you know if I learn anything.  When Richard wrote
APUE, aio was not defined by Posix.  Only the select/poll and turning
on the O_*SYNC flags hacks from BSD and SVR4.  I don't think you will
learn much from that.

As I said, many/most of the commerical Un*x folks added their own
propritary (and slightly different) version of aio years ago.   Then
they agreed on the Posix interface and most [if not all] have offered
those.  Most of the majpr ISV's that used their proprietary ones
have switched to or are in the process of switching too the Posi
interface for simpliticy [if they could - there are sometimes reasons
why they can not - not always technical reasons BTW].

I personally started to monitor this mailing list because I was
interested in Ben's work on aio for Linux and what I'm researching
needs to be follow what Linux is doing in this area.

For what ever its worth to this list: I have local implementations
of the Posix async I/O for a Sun and *BSD.  I trying to get my hands
on a Alpha and SVR5 [<-- bits secured for the later but no HW at
the moment to try it].  If you have any aio test cases, let me know.
As I do my research, if I can learn anything useful I'll be willing
to pass it on if you think it will help.

I'm currently thinking up/trying some examples and there are some
worrisome issues with the Posix spec IMHO.  I know that you
folks are not trying to be Posix compliant - which is both
a blessing and curse.

In my case, I need to follow Posix, since that's
what the ISVs really use as their guide.  My assumption is that
there will be mapping layer between your final interface and
the Posix interface.  I can offer any extensions as need/appropriate if
I can show that it helps [which in this case it might].

Clem
