Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264741AbTF0PXd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 11:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264766AbTF0PXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 11:23:32 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:33469 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264741AbTF0PXT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 11:23:19 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [BENCHMARK] O1int patch with contest
Date: Sat, 28 Jun 2003 01:40:08 +1000
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200306280041.47619.kernel@kolivas.org> <1056727700.584.3.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1056727700.584.3.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306280140.08726.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jun 2003 01:28, Felipe Alfaro Solana wrote:
> On Fri, 2003-06-27 at 16:41, Con Kolivas wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > I've had some (off list) requests to see if the interactivity patch I
> > posted shows any differences in contest. To be honest I wasn't sure it
> > would, and this is not quite what I expected. Below is a 2.5.73-mm1
> > patched with patch-O1int-0306271816 (2.5.73-O1i) compared to 2.5.73-mm1
> > with contest (http://contest.kolivas.org).
>
> These are good news, indeed. The patch is getting better and better, but
> I'm still seeing XMMS audio skips when clicking on a URL inside
> Evolution (and using Konqueror as my web browser), and sometimes when
> moving windows around.
>
> Also, it seems that nicing the X server to -20 causes it to get CPU at
> discontinuous bursts, causing window movement to be somewhat jerky. The
> overall feeling for the X server is better at a default nice of 0. Isn't
> this curious?

Not curious at all. I should have made it clear I was in _no_ way recommending 
renicing X. It should be left at nice 0 and the scheduler decide what is 
interactive. Renicing X will guarantee you of getting audio skips. 

There is still the problem of apps started during heavy loads. While the last 
patch helps a little, I have to do some more work on the algorithm and make 
it smarter to help a lot.

Con

