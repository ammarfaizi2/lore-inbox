Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVAQW7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVAQW7s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbVAQW4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:56:55 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:38629 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S262973AbVAQWoT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 17:44:19 -0500
From: Robert Wisniewski <bob@watson.ibm.com>
Message-Id: <200501172242.j0HMgrR56646@kix.watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Mon, 17 Jan 2005 17:42:53 -0500 (EST)
To: tglx@linutronix.de
Cc: Karim Yaghmour <karim@opersys.com>, Roman Zippel <zippel@linux-m68k.org>,
       Andi Kleen <ak@muc.de>, Nikita Danilov <nikita@clusterfs.com>,
       LKML <linux-kernel@vger.kernel.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
In-Reply-To: <1106001113.13265.474.camel@tglx.tec.linutronix.de>
References: <20050114002352.5a038710.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

n	<m1zmzcpfca.fsf@muc.de>
	<m17jmg2tm8.fsf@clusterfs.com>
	<20050114103836.GA71397@muc.de>
	<41E7A7A6.3060502@opersys.com>
	<Pine.LNX.4.61.0501141626310.6118@scrub.home>
	<41E8358A.4030908@opersys.com>
	<Pine.LNX.4.61.0501150101010.30794@scrub.home>
	<41E899AC.3070705@opersys.com>
	<Pine.LNX.4.61.0501160245180.30794@scrub.home>
	<41EA0307.6020807@opersys.com>
	<Pine.LNX.4.61.0501161648310.30794@scrub.home>
	<41EADA11.70403@opersys.com>
	<1105925842.13265.364.camel@tglx.tec.linutronix.de>
	<41EB21C2.3020608@opersys.com>
	<1105964417.13265.406.camel@tglx.tec.linutronix.de>
	<41EC20FB.9030506@opersys.com>
	<1106001113.13265.474.camel@tglx.tec.linutronix.de>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <16876.16024.551428.349980@kix.watson.ibm.com>
From: Robert Wisniewski <bob@watson.ibm.com>
Bcc: bob@watson.ibm.com,rosnbrg@watson.ibm.com

Thomas Gleixner writes:
 > On Mon, 2005-01-17 at 15:32 -0500, Karim Yaghmour wrote:
 > > You're either on crack or I don't know how to read english. Here's what
 > > you said:
 > 
 > Maybe you should read your own comment about ad-hominem attacks earlier
 > in this thread and consider if it might apply to you.
 > 
 > I know, what I have said. I said reduce the filtering to the absolute
 > minimum and do the rest in userspace.
 > 
 > The now builtin filters are defined to fit somebodys needs or idea of
 > what the user should / wants to see. They will not fit everybodys
 > needs / ideas. So we start modifying, adding and #ifdefing kernel
 > filters, which is a scary vision.
 > 
 > Enabling and disabling events is a valid basic filter request, which
 > should live in the kernel. Anything else should go into userspace, IMO.
 > 
 > tglx

I believe (and Karim can correct me if I'm wrong) the idea is to have
groups of events that can be disabled and enabled via a one word mask.  No
checking multiple variables, no #ifdefing, something very streamlined.  By
userspace I assume you mean post-processing, i.e., if the user/library/etc
needs to log events they use the same simple facility.

I think we agree to optimize/streamline performance for the gathering and
do work in the post processing.  There is an outstanding patch that makes
strides in this direction.

-bob

Robert Wisniewski
The K42 MP OS Project
http://www.research.ibm.com/K42/
bob@watson.ibm.com
