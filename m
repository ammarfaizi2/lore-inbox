Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbVAJH3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVAJH3D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 02:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVAJH3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 02:29:03 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:64667 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262130AbVAJH3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 02:29:00 -0500
From: Shaw <shawv@comcast.net>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Screwy clock after apm suspend
Date: Sun, 9 Jan 2005 23:28:53 -0800
User-Agent: KMail/1.7.2
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
       plazmcman@softhome.net, romosan@sycorax.lbl.gov
References: <7bb8b8de05010710085ea81da9@mail.gmail.com> <20050109224711.GF1353@elf.ucw.cz>
In-Reply-To: <20050109224711.GF1353@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200501092328.54092.shawv@comcast.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 January 2005 02:47 pm, Pavel Machek wrote:
> Probably code to compensate clock after ACPI suspend breaks apm case
>
> arch/i386/kernel/time.c, can you comment out
> jiffies += sleep_length * HZ;
>
> in timer_resume to see if it goes away?

Worked like a charm.  I'm not seeing any time drift after your suggested 
change.

Thanks,
Shaw
