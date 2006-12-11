Return-Path: <linux-kernel-owner+w=401wt.eu-S1762466AbWLKF0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762466AbWLKF0w (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 00:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762413AbWLKF0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 00:26:52 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:62345 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762431AbWLKF0v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 00:26:51 -0500
Message-ID: <457CEC0F.2030206@anagramm.de>
Date: Mon, 11 Dec 2006 06:26:39 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Folkert van Heusden <folkert@vanheusden.com>, linux-kernel@vger.kernel.org
Subject: Re: optimalisation for strlcpy (lib/string.c)
References: <20061210212350.GC30197@vanheusden.com> <20061210231305.GG10351@stusta.de>
In-Reply-To: <20061210231305.GG10351@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:224ad0fd4f2efe95e6ec4f0a3ca8a73c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Adrian & Friends!

>> Like the other patch (by that other person), I think it is faster to not
>> do a strlen first.

There are PowerPC architectures, where a strlen is a matter of a single
instruction of the CPU.

Quote: "PowerPC 405 and 440 instruction sets offer the powerful
Determine Left-Most Zero Byte (DLMZB) instruction."

That's propably hard to beat.

So, if we really want to speed up these things, we should write
code which helps the compiler get that optimized instructions for
us - by improving the code of strlen() i.e.

Reference:
http://www-03.ibm.com/chips/power/powerpc/newsletter/sep2003/ppc_process_at_work2.html

Greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm-technology.com
Phone: +49-89-741518-50
Fax: +49-89-741518-19

