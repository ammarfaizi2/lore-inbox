Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319376AbSH2Xzr>; Thu, 29 Aug 2002 19:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319404AbSH2Xzr>; Thu, 29 Aug 2002 19:55:47 -0400
Received: from pc-80-195-6-65-ed.blueyonder.co.uk ([80.195.6.65]:34949 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S319376AbSH2Xzr>; Thu, 29 Aug 2002 19:55:47 -0400
Date: Fri, 30 Aug 2002 00:59:31 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: walt <walt@nea-fast.com>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: 2.4.19 ext3 oops with file system damage - possible nfs and ext3 not playing nice together
Message-ID: <20020830005931.D23868@redhat.com>
References: <200208281451.12117.walt@nea-fast.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208281451.12117.walt@nea-fast.com>; from walt@nea-fast.com on Wed, Aug 28, 2002 at 02:51:12PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 28, 2002 at 02:51:12PM -0400, walt wrote:
 
> without any errors being reported. When I'd try gunzip the file from CD, I'd 
> get CRC errors. I then tried mounting the ISO image and running gunzip and 
> I'd get the same CRC errors. 

That's usually a hardware or driver, not filesystem, problem.  I've
had a couple of environments which have given data corruptions like
that on IDE drivers in UDMA mode but which were fine in MDMA or PIO
mode.  

> no problems. All this was repeatable. I upgraded kernels from RedHat 7.3 
> stock  2.4.18-3 to vanilla 2.4.19 and problem seemed to go away. 

That can be just a matter of the config options used masking a driver
problem.  Can you still reproduce with "ide=nodma"?  That would
certainly point towards a driver or hardware fault.

--Stephen
