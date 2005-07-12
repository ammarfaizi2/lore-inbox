Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVGLLQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVGLLQI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 07:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVGLLMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 07:12:14 -0400
Received: from spc2-brig1-3-0-cust232.asfd.broadband.ntl.com ([82.1.142.232]:12483
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S261337AbVGLLMA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 07:12:00 -0400
Date: Tue, 12 Jul 2005 12:11:56 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Eric Piel <Eric.Piel@lifl.fr>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: ondemand cpufreq ineffective in 2.6.12 ?
In-Reply-To: <Pine.LNX.4.58.0507121131001.7702@ppg_penguin.kenmoffat.uklinux.net>
Message-ID: <Pine.LNX.4.58.0507121203450.7944@ppg_penguin.kenmoffat.uklinux.net>
References: <Pine.LNX.4.58.0507111702410.2222@ppg_penguin.kenmoffat.uklinux.net>
 <Pine.LNX.4.58.0507112044001.3450@ppg_penguin.kenmoffat.uklinux.net>
 <200507120755.03110.kernel@kolivas.org> <42D3782F.7070104@lifl.fr>
 <Pine.LNX.4.58.0507121131001.7702@ppg_penguin.kenmoffat.uklinux.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2005, Ken Moffat wrote:

>  I was going to say that niceness didn't affect what I was doing, but
> I've just rerun it [ in 2.6.11.9 ] and I see that tar and bzip2 show up
> with a niceness of 10.  I'm starting to feel a bit out of my depth here

OK, Con was right, and I didn't initially make the connection.

 In 2.6.11, untarring a .tar.bz2 causes tar and bzip2 to run with a
niceness of 10, but everything is fine.

 In 2.6.12, ondemand _only_ has an effect for me in this example if I
put on my admin hat and renice the bzip2 process (tried 0, that works) -
renicing the tar process has no effect (obviously, that part doesn't
push the processor).

So, from a user's point of view it's broken.

Ken
-- 
 das eine Mal als Tragödie, das andere Mal als Farce

