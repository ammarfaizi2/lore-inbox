Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268410AbUIBPLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268410AbUIBPLS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 11:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUIBPKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 11:10:55 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:54224 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268407AbUIBPKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 11:10:37 -0400
Message-ID: <93e09f0104090208106c0e907d@mail.gmail.com>
Date: Thu, 2 Sep 2004 20:40:28 +0530
From: Rohit Neupane <rohitneupane@gmail.com>
Reply-To: Rohit Neupane <rohitneupane@gmail.com>
To: "kwijibo@zianet.com" <kwijibo@zianet.com>
Subject: Re: Weird Problem with TCP
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41372F3A.4040301@zianet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <93e09f0104090202216403c08d@mail.gmail.com> <1094122617.4966.0.camel@localhost.localdomain> <93e09f0104090206334a708289@mail.gmail.com> <41372F3A.4040301@zianet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Sep 2004 08:33:30 -0600, kwijibo@zianet.com
<kwijibo@zianet.com> wrote:
> Are you sure you don't have any rules that have "state" listed in them?
> It really does sound like you have a stateful firewall.  But in the case
> that you don't, try logging our TCP rules that don't appear to be working.

Yes i am sure I don't have any state in the firewall. Infact we were
aware of the state problem from the beginning hence we didn't include
in the firewall at all.
And the problem is not just with one IP. It happens with almost all
client but ramdomly.
If there is any test that I need to carry out then please suggest.
Also, please not that I am running HTB and SFQ for b/w shaping purpose
on the same machine.

Rohit

> 
> Steve
> 
> 
> 
> Rohit Neupane wrote:
> 
> >On Thu, 02 Sep 2004 11:56:59 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >
> >
> >>>* Everything works fine for about 5-10 mins then all of a sudden TCP services
> >>>are not accessable.
> >>>* For some reason TCP times out. However at the same time ping,traceroute and
> >>>dns trace works without any problem.
> >>>* The connected TCP sokets keeps working without any problem. I verified this
> >>>by using Msn chat. I observerd that I chat session ( which I had started
> >>>when everything was normal) continued without any problem however I was not
> >>>able to initiate a new chat session.
> >>>
> >>>
> >>Are you using session tracking. The symptoms you describe are
> >>classically those of session tracking nat/firewalling/whatever running
> >>out of table entries and being unable to allow new connections.
> >>
> >>
> >>
> >No, it is not running any session tracking (ip_conntrack) neither it
> >does nat. It is just a firewall with around 1600 rules in FORWARD
> >mangle table and around 1500 rules in FORWARD filter table. Out of
> >1500 rules , 1377 rules are MAC filter rules.
> >And it had 3 alias address for the interface conneted to the wirelss.
> >
> >regards,
> >Rohit
> >
> >
> >
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
> >
> >
> 
>
