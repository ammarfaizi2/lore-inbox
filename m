Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVDKNBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVDKNBS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 09:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVDKNBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 09:01:18 -0400
Received: from gate.corvil.net ([213.94.219.177]:43785 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S261681AbVDKNBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 09:01:00 -0400
Message-ID: <425A74F8.8050006@draigBrady.com>
Date: Mon, 11 Apr 2005 14:00:40 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kus Kusche Klaus <kus@keba.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: RT 45-01: CF Card read: High latency?
References: <AAD6DA242BC63C488511C611BD51F3673231EA@MAILIT.keba.co.at>
In-Reply-To: <AAD6DA242BC63C488511C611BD51F3673231EA@MAILIT.keba.co.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I handled this issue by precaching all my files (15MB),
from my readonly root filesystem.

find / -type f |
grep -v ^/boot | #kernel is > 1MB and never read so don't put in cache
while read file; do
     dd bs=32k if="$file" of=/dev/null 2>/dev/null
done

Pádraig.
