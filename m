Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262708AbVA0Toj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbVA0Toj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 14:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbVA0Toj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 14:44:39 -0500
Received: from p-mail2.rd.francetelecom.com ([195.101.245.16]:2824 "EHLO
	p-mail2.rd.francetelecom.com") by vger.kernel.org with ESMTP
	id S262708AbVA0Toi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 14:44:38 -0500
Message-ID: <41F94462.7080108@francetelecom.REMOVE.com>
Date: Thu, 27 Jan 2005 20:43:30 +0100
From: Julien TINNES <julien.tinnes.NOSPAM@francetelecom.REMOVE.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Patch 4/6  randomize the stack pointer
References: <20050127101117.GA9760@infradead.org> <20050127101322.GE9760@infradead.org>
In-Reply-To: <20050127101322.GE9760@infradead.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Jan 2005 19:42:39.0478 (UTC) FILETIME=[5C051160:01C504A8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not very important but ((get_random_int() % 4096) << 4) could be 
optimized into get_random_int() & 0xFFF0. Because 4096 is a power of 2 
you won't loose any entropy by doing  & 0xFFF instead of %4096

Regards,

-- 
Julien TINNES - & france telecom - R&D Division/MAPS/NSS
Research Engineer - Internet/Intranet Security
GPG: C050 EF1A 2919 FD87 57C4 DEDD E778 A9F0 14B9 C7D6

