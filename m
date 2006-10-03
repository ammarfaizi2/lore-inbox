Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbWJCLKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbWJCLKt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 07:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030308AbWJCLKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 07:10:49 -0400
Received: from main.gmane.org ([80.91.229.2]:41159 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030302AbWJCLKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 07:10:48 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Gordon Cormack <gvcormac@uwaterloo.ca>
Subject: Re: Spam, bogofilter, etc
Date: Tue, 3 Oct 2006 10:50:51 +0000 (UTC)
Message-ID: <loom.20061003T123315-373@post.gmane.org>
References: <1159539793.7086.91.camel@mindpipe>  <20061002100302.GS16047@mea-ext.zmailer.org> <1159802486.4067.140.camel@mindpipe> <45212F39.5000307@mbligh.org> <Pine.LNX.4.64.0610020933020.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.57.130.245 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5 Mnenhy/0.7.3.0)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds <at> osdl.org> writes:

> I'm sorry, but spam-filtering is simply harder than the bayesian 
> word-count weenies think it is. I even used to _know_ something about 
> bayesian filtering, since it was one of the projects I worked on at uni, 
> and dammit, it's not a good approach, as shown by the fact that it's 
> trivial to get around.

Linus, I've seen no evidence that statistical filters are trivial
to beat.  Can you provide some? 

> I don't know why people got so excited about the whole bayesian thing. 
> It's fine as _one_ small clause in a bigger framework of deciding spam, 
> but it's totally inappropriate for a "yes/no" kind of decision on its own.

Why is that?  Statistical filters (so-called 'Bayesian) have lower 
false positive and false negative rates than many other approaches.
Bogofilter is one of the better ones, although it is not particularly
Bayesian.
 
> If you want a yes/no kind of thing, do it on real hard issues, like not 
> accepting email from machines that aren't registered MX gateways. Sure, 
> that will mean that people who just set up their local sendmail thing and 
> connect directly to port 25 will just not be able to email, but let's face 
> it, that's why we have ISP's and DNS in the first place.

You are saying that this sort of false positive is acceptable to
you.  With no corresponding claim as to the corresponding false
negative rate.

So-called yes/no values are simply tests with their own failure
rates.  As such, they have strictly less information than 
scores or probability estimates that offer a confidence
estimate as well.  The trick is in combining several sources
of evidence, and 'Bayesian' is but one method of combining this
evidence.  
> 
> If you want to do word analysis, use it like SpamAssassin does it - with 
> some Bayesian rule perhaps adding a few points to the score. That's 
> entirely appropriate. But running bogo-filter _instead_ of spamassassin is 
> just asinine.

Spamassassin performs quite poorly with the default weight
given to its statistical filter.  It works much better
if you increase the weight.  Many tests show that it works
better still if you simply discard the ad hoc rules and
rely on the 'Bayesian' filter alone.  I have found that
almost all of the false positives I've encountered in
the last 3 years have been due to Spamassassin's ad hoc
rules, not its statistical filter.

References

   http://plg.uwaterloo.ca/~gvcormac/trecspamtrack05
   http://plg.uwaterloo.ca/~gvcormac/spamassassin.html
   http://www.ceas.cc/2006/listabs.html#12.pdf

Gordon Cormack
University of Waterloo




