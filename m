Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVA1IpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVA1IpO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 03:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVA1IpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 03:45:14 -0500
Received: from p-mail2.rd.francetelecom.com ([195.101.245.16]:40454 "EHLO
	p-mail2.rd.francetelecom.com") by vger.kernel.org with ESMTP
	id S261204AbVA1IpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 03:45:09 -0500
Message-ID: <41F9FBC1.5000204@francetelecom.REMOVE.com>
Date: Fri, 28 Jan 2005 09:45:53 +0100
From: Julien TINNES <julien.tinnes.NOSPAM@francetelecom.REMOVE.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Patch 4/6 randomize the stack pointer
References: <200501280203.j0S23Fc8008333@laptop11.inf.utfsm.cl>
In-Reply-To: <200501280203.j0S23Fc8008333@laptop11.inf.utfsm.cl>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jan 2005 08:45:02.0294 (UTC) FILETIME=[A81E5760:01C50515]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> Julien TINNES <julien.tinnes.NOSPAM@francetelecom.REMOVE.com> said:
> 
>>Not very important but ((get_random_int() % 4096) << 4) could be 
>>optimized into get_random_int() & 0xFFF0.
> 
> 
> Check first if the compiler doesn't do it by itself.

The compiler cannot guess that get_random_int() gives a random result. 
%4096 and & 0xFFF is'nt the same operation. But (get_random_int() % 
4096) and (get_random_int() & 0xFFF) gives the same result: a random 
number between 0 and 4095, without loss of entropy because 0xFFF has no 
0 bit.

-- 
Julien TINNES - & france telecom - R&D Division/MAPS/NSS
Research Engineer - Internet/Intranet Security
GPG: C050 EF1A 2919 FD87 57C4 DEDD E778 A9F0 14B9 C7D6
