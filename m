Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751540AbVIZMPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbVIZMPw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 08:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbVIZMPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 08:15:52 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:57771 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S1751431AbVIZMPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 08:15:51 -0400
Message-ID: <4337E601.1070208@cs.aau.dk>
Date: Mon, 26 Sep 2005 14:13:53 +0200
From: Emmanuel Fleury <fleury@cs.aau.dk>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hadi@cyberus.ca
CC: Michael Bellion <mbellion@hipac.org>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [ANNOUNCE] Release of nf-HiPAC 0.9.0
References: <200509260445.46740.mbellion@hipac.org>	 <4337DA7C.2000804@cs.aau.dk> <1127735881.6215.294.camel@localhost.localdomain>
In-Reply-To: <1127735881.6215.294.camel@localhost.localdomain>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

jamal wrote:
>
> To repeat the tests i mentioned earlier for clarity:
> a) Variable incoming packet rate (in packets per second)
> b) Variable packet sizes
> c) Variable number of users/filters
> d) Effect of adding/removing/modifying policies while under different
> incoming traffic rates.
>
> You seem to have taken care of most of the variables involved except
> for #d below. If you look at my slides you will see why #d is
> important to have in modern firewalls. I think if you have to first
> compile rules then you will have issues, but it remains to be seen.

That is right, the add/remove/modifying policies was still an issue when
we stopped working on this. But, I think we can solve this problem by
working on an incremental compiler. I have to admit that this require a
proof of concept. This issue is quite critical on our method.

> Several comments:
> - Am i mistaken that your source of data is from somewhere in the
> backbone? Would it be fair to say that something in the edge would be
> more appropriate?

The source of the data has been recorded from a backbone but all the
clients in the experimental setting are replaying part of it and sending
it to the gigabit switch.

> - Your header extraction tool creates "10 sets of rules"; is there a
> reason for the number 10?

No particular reason.

> - Is tcpreplay the right tool? What does it give you that you cant use
> a better blaster like pktgen?

The idea was to replay a realistic traffic. So we used a slightly
modified version of the tcpreplay (I don't remember what modifications
have been done, my co-author did it). I should definitely take a look at
pktgen.

> - I think the blackbox monitor looking at the input vs output tool is
> good. It will be more complete if you can quantify the input rate then
> you can easily quantify output rate.

Interesting suggestion. Thanks.

> - While your results were useful in showing Mbps; they are incomplete
> by not mentioning the packet size. A better metric would have been
> pps. But even then mentioning packet size is also useful.

Right, the packet size was 300bytes (I think this is mentioned in the
text but not highlighted in the figures). I agree with you about pps (we
were young and innocent at the time).

> If you are going to run these tests in stateless firewalling as you
> did, please consider using tc filter as well.

The spirit was to test a totally new idea, the plan was not really to
get integrated (yet) into any tool, so we did it like this. We might
have been wrong.

Thanks for your comments.

Regards
-- 
Emmanuel Fleury

The highest goal of computer science is to automate that
which can be automated.
  -- D. L. VerLee
