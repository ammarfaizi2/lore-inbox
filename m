Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965036AbVLaS7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbVLaS7k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 13:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbVLaS7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 13:59:40 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:14176 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965036AbVLaS7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 13:59:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=YhmEAYpiHexbYBuVrHa6JDh0II4Y3M7OfSsaUWK0UBhUM/wP9tM6hcKLpTWCiZgQaiBelsqVOfi0wiEMbzsiWMDr/poDGUszFo+KB1N6Yd4lOwOrP6udUime1aGOxBipYxoIF+yqo9s72OrH5fCCE+TRR2cL4lkcSs9392Mt7bA=
Date: Sat, 31 Dec 2005 20:59:31 +0200
From: Bradley Reed <bradreed1@gmail.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MPlayer broken under 2.6.15-rc7-rt1?
Message-ID: <20051231205931.119f3dc7@galactus.example.org>
In-Reply-To: <200512311847.48296.s0348365@sms.ed.ac.uk>
References: <20051231202933.4f48acab@galactus.example.org>
	<200512311847.48296.s0348365@sms.ed.ac.uk>
X-Mailer: Sylpheed-Claws 1.9.100cvs108 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Dec 2005 18:47:48 +0000
Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> Try mplayer -nortc? If that work's it'll confirm the problem is with
> opening the rtc device.
> 

It works fine with the -nortc option. I wonder why it can't open it? It
exists and the perms look pretty wide open.

breed@galactus:~[1024]$ ls -l /dev/rtc
lrwxrwxrwx  1 root root 8 2005-12-31 19:37:09 /dev/rtc -> misc/rtc
breed@galactus:~[1025]$ ls -l /dev/misc/rtc
crw-rw-rw-  1 root root 10, 135 2005-12-31 19:36:03 /dev/misc/rtc

Thanks,
Brad
