Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315038AbSD2Ki1>; Mon, 29 Apr 2002 06:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315030AbSD2Ki1>; Mon, 29 Apr 2002 06:38:27 -0400
Received: from mail.webmaster.com ([216.152.64.131]:56203 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S315028AbSD2Ki0> convert rfc822-to-8bit; Mon, 29 Apr 2002 06:38:26 -0400
From: David Schwartz <davids@webmaster.com>
To: <terje.eggestad@scali.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Mon, 29 Apr 2002 03:38:22 -0700
In-Reply-To: <1020074594.22026.38.camel@pc-16.office.scali.no>
Subject: Re: Possible bug with UDP and SO_REUSEADDR.
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020429103823.AAA26425@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>However, I still can't see any *practical* use of having one program
>(me) bind the port, deliberately share it, and another program (you)
>coming along and want to share it, and then all unicast datagrams are
>passed to you. Not If I haven't subscribed to any multicast addresses,
>and no one is sending bcasts, there is no point of me being alive.
>
>Can you come up with a real life situation where this make sense?

	Absolutely. This is actually used in cases where you have a 'default' 
handler for a protocol that is built into a larger program but want to keep 
the option to 'override' it with a program with more sophisticated behavior 
from time to time. In this case, the last socket should get all the data 
until it goes away.

	DS




