Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315607AbSGXJ2v>; Wed, 24 Jul 2002 05:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315708AbSGXJ2v>; Wed, 24 Jul 2002 05:28:51 -0400
Received: from boden.synopsys.com ([204.176.20.19]:38531 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S315607AbSGXJ2u>; Wed, 24 Jul 2002 05:28:50 -0400
Date: Wed, 24 Jul 2002 11:31:52 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: "D.A.M.Revok" <marvin@synapse.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compile Bogons in 2.4.19-rc3 with Caldera OpenLinux 3.1's patched 2.95.2
Message-ID: <20020724093152.GB14143@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: "D.A.M.Revok" <marvin@synapse.net>,
	linux-kernel@vger.kernel.org
References: <20020724082557Z318273-685+17059@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020724082557Z318273-685+17059@vger.kernel.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2002 at 04:29:03AM -0400, D.A.M.Revok wrote:
> make dep clean bzImage modules > /dev/null ( to make me see the erors, since 

make -s clean
make -s dep bzImage modules

You better do not combine clean targets with build targets. If you
someday will try the command on a multi-processor machine, and being
excited about all its power, place something like '-j2' in the line,
heaven knows what you'll get.

'-s' is for 'silent' builds, and turns off displaying of the executed
commands (not for version generation, though, very incovenient problem
in the kbuild-2.4).


