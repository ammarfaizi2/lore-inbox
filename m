Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261823AbTDBHDJ>; Wed, 2 Apr 2003 02:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261842AbTDBHDJ>; Wed, 2 Apr 2003 02:03:09 -0500
Received: from smtpde02.sap-ag.de ([155.56.68.170]:23747 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S261823AbTDBHDH>; Wed, 2 Apr 2003 02:03:07 -0500
From: Christoph Rohland <cr@sap.com>
To: Daniel Egger <degger@fhm.edu>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
Organisation: Development SAP J2EE Engine
Date: Wed, 02 Apr 2003 09:13:39 +0200
In-Reply-To: <1049221575.7628.14.camel@localhost> (Daniel Egger's message of
 "01 Apr 2003 20:26:15 +0200")
Message-ID: <ovfzp1l6cc.fsf@sap.com>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) XEmacs/21.4 (Native Windows TTY
 Support (Windows), cygwin32)
References: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE982@mailse01.se.axis.com>
	<ovn0jakwy7.fsf@sap.com> <1049221575.7628.14.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 01 Apr 2003, Daniel Egger wrote:
> Just curious: Why? I'm using tmpfs on these systems and I'm rather
> satisfied with it; especially the option to limit the amount of
> space makes it rather useful. According to the documentation ramfs
> is most useful as an educational example how to write filesystems
> not as a real filesystem...

Uuh, now you are beating me with my old statements ;-)

tmpfs has the drawback that the in memory data structures are bigger
than ramfs'. But the core of tmpfs is always compiled in for anonymous
shared memory. And it has size limits. So you are probably right, that
tmpfs is the right choice. 

But you are arguing at a corner case. tmpfs is IMHO more often used on
machines with swap and (at least for me) the use of swap as store for
temporary data is the big point to use tmpfs. So the percentile should
take swap into account.

Greetings
		Christoph


