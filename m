Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264130AbTDPUmu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 16:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264584AbTDPUmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 16:42:50 -0400
Received: from mail.hometree.net ([212.34.181.120]:471 "EHLO mail.hometree.net")
	by vger.kernel.org with ESMTP id S264130AbTDPUms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 16:42:48 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: How to identify contents of /lib/modules/*
Date: Wed, 16 Apr 2003 20:54:40 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <b7kfug$4ao$1@tangens.hometree.net>
References: <45B36A38D959B44CB032DA427A6E1064045133AB@cceexc18.americas.cpqcorp.net> <1050508885.28727.137.camel@dhcp22.swansea.linux.org.uk>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1050526480 4440 212.34.181.4 (16 Apr 2003 20:54:40 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Wed, 16 Apr 2003 20:54:40 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>Only --force allows the same file to be owned by two packages. Otherwise

No. Look at this:

% rpm -qf /usr/lib/libamanda-2.4.4.so
amanda-client-2.4.4-2t
amanda-server-2.4.4-2t

%  rpm -ql amanda-client | grep libamanda
/usr/lib/libamanda-2.4.4.so
/usr/lib/libamanda.so
% rpm -ql amanda-server | grep libamanda
/usr/lib/libamanda-2.4.4.so
/usr/lib/libamanda.so

rpm allows this if both rpms supply an identical file. Which they do
(they're cut from the same SRPM). It's not nice but it definitely
works without --force. I never use --force on rpm.

This is on RedHat 7.3 with rpm-4.0.4-7x.18

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire
