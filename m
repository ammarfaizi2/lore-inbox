Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277867AbRJIR3t>; Tue, 9 Oct 2001 13:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277864AbRJIR3f>; Tue, 9 Oct 2001 13:29:35 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:25613 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S277863AbRJIR3Y>; Tue, 9 Oct 2001 13:29:24 -0400
X-Apparently-From: <trever?adams@yahoo.com>
Subject: Re: iptables in 2.4.10, 2.4.11pre6 problems
From: "Trever L. Adams" <trever_adams@yahoo.com>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0110091005540.209-100000@desktop>
In-Reply-To: <Pine.LNX.4.33.0110091005540.209-100000@desktop>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 09 Oct 2001 13:30:14 -0400
Message-Id: <1002648616.2580.18.camel@aurora>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-10-09 at 13:07, Jeffrey W. Baker wrote:
> I see this too.  iptables is refusing packets on locally-initiated TCP
> connections when the RELATED,ESTABLISHED rule should be letting them
> through.
> 
> I mentioned this problem on the netfilter list but my message fell into
> a black hole and was apparently beyond the horizon of the developers.
> 
> -jwb

Maybe I misunderstand you, define locally-initiated.  Do you mean net or
do you mean box?  Mine happens on connections made by the firewall
(proxy for web) and on other connections initiated internally.  We
currently only allow identd and a few others from external (identd is
spoofed more or less).

I am glad I am not the only one seeing this problem.  I have the
established, related as well.  The only thing that should be dropped
before it gets handled is certain ICMP messages (if someone thinks I am
dropping something I shouldn't, let me know) and windows networking
datagrams (used to keep the line up from internal machines, so I killed
it).

The big problems I have are a few websites and digitalme.com (all
services... web, mail, etc.).

Trever Adams


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

