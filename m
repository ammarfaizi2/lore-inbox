Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312694AbSD2PwF>; Mon, 29 Apr 2002 11:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312696AbSD2PwF>; Mon, 29 Apr 2002 11:52:05 -0400
Received: from news.indigo-avs.com ([194.200.210.131]:40789 "EHLO
	pilmuir.indigo-avs.com") by vger.kernel.org with ESMTP
	id <S312694AbSD2PwD>; Mon, 29 Apr 2002 11:52:03 -0400
Date: Mon, 29 Apr 2002 16:49:23 +0100
From: Yves Rutschle <y.rutschle@indigovision.com>
To: Murtada Shah <mshah@yottayotta.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: speeding up i2c drivers
Message-ID: <20020429164923.A31209@localhost>
Mail-Followup-To: Murtada Shah <mshah@yottayotta.com>,
	linux-arm-kernel@lists.arm.linux.org.uk,
	linux-kernel@vger.kernel.org
In-Reply-To: <3CCD6762.9040406@yottayotta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2002 at 09:31:46AM -0600, Murtada Shah wrote:
> I want to speed up the linux kernel i2c drivers. They are running @ 
> 10Khz now, although i2c is capable of 100. Would anyone be able to point 
> me to the right direction?

Look in drivers/i2c/*

The details depend on what algorithm your interface uses.
For "bitbanging" algorithm for example, timing information
is coded in the last parameters of the struct
i2c_algo_bit_data.

That said, i2c normally automatically slows down at the
speed of the slowest device on the bus, so it may well be
that the 10Khz you see has nothing to do with your kernel
driver.

HTH,
Y.

