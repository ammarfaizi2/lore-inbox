Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267765AbTGONsU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 09:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267773AbTGONsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 09:48:19 -0400
Received: from eta.fastwebnet.it ([213.140.2.50]:54729 "EHLO eta.fastwebnet.it")
	by vger.kernel.org with ESMTP id S267765AbTGONsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 09:48:13 -0400
Date: Tue, 15 Jul 2003 16:03:54 +0200
From: Mattia Dongili <dongili@supereva.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-test1] on a vaio GR laptop (one more)
Message-ID: <20030715140354.GB3365@inferi.kami.home>
Reply-To: dongili@supereva.it
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030715133816.GA1074@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715133816.GA1074@inferi.kami.home>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 03:38:16PM +0200, Mattia Dongili wrote:
> hi, here's some problems running the 1st 2.6 test kernel on this vaio
> gr7k, a japanese model.
> 
> 1. I've lost the '|' (pipe) keystroke in console, showkey reports the
>    following:
>      0   press
>      1   release
>     55   release
>      0   relesase
>      1   release
>     55   release
>   This laptop is equipped with a japanese keyboard so the | key is just
>   above the Yen key. This problem was already here in 2.5.7X (haven't
>   tested previous kernels).
>   Using an xterm give me the | key back using this config option:
>       Option          "XkbModel"      "jp106"
>       Option          "XkbLayout"     "jp"
> 
> 2. an Oops. In 2.4.21 happens the same. It's 100% reproducible, you
>    just need to launch 'kon' (a kanji capable console) from an xterm.
>    After the oops the computer is still usable, I can trigger more oops
>    in the same manner :)
> 
> 3. spurious 8259A interrupt: IRQ7
>    this appeared also in 2.5.7X... never had one with the 2.4 series
 
4. found this in the logs:
   Jul 15 15:40:11 inferi kernel:      osl-0883 [1335] os_wait_semaphore : Failed to acquire semaphore[cff7e640|1|0], AE_TIME
   Jul 15 15:51:11 inferi kernel:      osl-0883 [1923] os_wait_semaphore : Failed to acquire semaphore[cff7e640|1|0], AE_TIME
   Jul 15 15:59:01 inferi kernel:      osl-0883 [2339] os_wait_semaphore : Failed to acquire semaphore[cff7e640|1|0], AE_TIME

-- 
mattia
:wq!
