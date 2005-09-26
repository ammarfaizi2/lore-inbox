Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbVIZCvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbVIZCvo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 22:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbVIZCvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 22:51:44 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:58248 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751609AbVIZCvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 22:51:43 -0400
From: Michael Bellion <mbellion@hipac.org>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Subject: [ANNOUNCE] Release of nf-HiPAC 0.9.0
Date: Mon, 26 Sep 2005 04:45:46 +0200
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509260445.46740.mbellion@hipac.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am happy to announce the release of nf-HiPAC version 0.9.0

During the development of version 0.9.0 everything was ported to Linux kernel 
2.6 and large parts of the kernel code have been rewritten.
The kernel patch is now fairly non-intrusive: it only adds one simple function 
to ip_tables.c. The rest of the patch introduces new files to the kernel. 
The new release fixes all known bugs and also introduces some new features.

Since the last release I have become part of MARA Systems AB 
( http://www.marasystems.com ). MARA Systems AB is now the commercial backer 
of the HiPAC Project and finances it completely. Together MARA Systems and I 
will make sure that HiPAC is actively maintained and further developed under 
the GNU GPL.


For all of you who don't know nf-HiPAC yet, here is a short overview:

nf-HiPAC is a full featured packet filter for Linux which demonstrates the
power and flexibility of HiPAC. HiPAC is a novel framework for packet
classification which uses an advanced algorithm to reduce the number of
memory lookups per packet. It is ideal for environments involving large rule
sets and/or high bandwidth networks.

nf-HiPAC provides the same rich feature set as iptables, the popular Linux
packet filter. The complexity of the sophisticated HiPAC packet
classification algorithm is hidden behind an iptables compatible user
interface which renders nf-HiPAC a drop-in replacement for iptables. Thereby,
the iptables' semantics of the rules is preserved, i.e. you can construct your
rules like you are used to. From a user's point of view there is no need to
understand anything about the HiPAC algorithm.

The nf-hipac user space tool is designed to be as compatible as possible to
'iptables -t filter'. It even supports the full power of iptables targets,
matches and stateful packet filtering (connection tracking) besides the native
nf-HiPAC matches. This makes a switch from iptables to nf-HiPAC very easy.
Usually it is sufficient to replace the calls to iptables with calls to
nf-hipac for your filter rules.

Why another packet filter?
Performance:
    iptables, like most packet filters, uses a simple packet classification
    algorithm which traverses the rules in a chain linearly per packet until a
    matching rule is found (or not). Clearly, this approach lacks efficiency.
    As networks grow more and more complex and offer a wider bandwidth linear
    packet filtering is no longer an option if many rules have to be matched
    per packet. Higher bandwidth means more packets per second which leads to
    shorter process times per packet. nf-HiPAC outperforms iptables regardless
    of the number of rules, i.e. the HiPAC classification engine does not
    impose any overhead even for very small rule sets.

Scalability to large rule sets:
    The performance of nf-HiPAC is nearly independent of the number of rules.
    nf-HiPAC with thousands of rules still outperforms iptables with 20 rules.

Dynamic rule sets:
    nf-HiPAC offers fast dynamic rules et updates without stalling packet
    classification in contrast to iptables which yields bad update performance
    along with stalled packet processing during updates.

More information about the project can be found at:    http://www.hipac.org
The releases are published on:    http://sourceforge.net/projects/nf-hipac/

Enjoy,
    +---------------------------+
    |      Michael Bellion      |
    |   <mbellion@hipac.org>    |
    +---------------------------+
