Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262775AbVDAQHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbVDAQHK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 11:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbVDAQHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 11:07:10 -0500
Received: from 76.80-203-227.nextgentel.com ([80.203.227.76]:58335 "EHLO
	mail.inprovide.com") by vger.kernel.org with ESMTP id S262775AbVDAQHB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 11:07:01 -0500
To: Wiktor <victorjan@poczta.onet.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFD] 'nice' attribute for executable files
References: <fa.ed33rit.1e148rh@ifi.uio.no>
	<E1DGNaV-0005LG-9m@be1.7eggert.dyndns.org>
	<424ACEA9.6070401@poczta.onet.pl>
	<yw1xpsxhvzsz.fsf@ford.inprovide.com>
	<424AE18B.1080009@poczta.onet.pl>
	<yw1xll85vtva.fsf@ford.inprovide.com>
	<424B090F.3090508@poczta.onet.pl>
	<yw1xhdisx3th.fsf@ford.inprovide.com>
	<424D6821.4010709@poczta.onet.pl>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Fri, 01 Apr 2005 18:07:00 +0200
In-Reply-To: <424D6821.4010709@poczta.onet.pl> (Wiktor's message of "Fri, 01
 Apr 2005 17:26:25 +0200")
Message-ID: <yw1x3buaqy57.fsf@ford.inprovide.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wiktor <victorjan@poczta.onet.pl> writes:

> Måns Rullgård wrote:
>> So you are proposing the addition of a per-file attribute, with
>> restricted access, and potentially dangerous effects if set
>> incorrectly.  This, combined with the fact that is unlikely to receive
>> much testing, all speaks against it.
>>
>
> Almost every attribute can be dangerous if set incorrectly. Bot it is
> really no problem - simply let's turn to fat12 as root filesystem, and
> no attribute will be dangerous any more... See that acl-s also are not
> used for every file, only for some files, ones of thousands files in
> the filesystem. They are not set and reset every ten minutes - they
> are set one time and used, used and used. The same applies to nice
> attribute. Is it dangerous to not modify attribute all the time? And
> why restricted access is riskfull and evil?

The problem is in ensuring that access really is as restricted as you
think it is.  How will you deal with removable devices, and network
filesystems?  We really don't want all the concerns associated with
the SUID/SGID bits in yet another place.

Most importantly, though, hacks like this to work around bugs in
applications is not the proper thing to do.

-- 
Måns Rullgård
mru@inprovide.com
