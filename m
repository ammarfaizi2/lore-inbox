Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292475AbSBPSSg>; Sat, 16 Feb 2002 13:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292476AbSBPSS0>; Sat, 16 Feb 2002 13:18:26 -0500
Received: from ns.suse.de ([213.95.15.193]:61969 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292475AbSBPSSP>;
	Sat, 16 Feb 2002 13:18:15 -0500
Date: Sat, 16 Feb 2002 19:18:14 +0100
From: Dave Jones <davej@suse.de>
To: Rudmer van Dijk <rudmer@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1, allow RAM disk to be build
Message-ID: <20020216191814.B4777@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Rudmer van Dijk <rudmer@linuxmail.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020216180735.7807.qmail@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020216180735.7807.qmail@linuxmail.org>; from rudmer@linuxmail.org on Sun, Feb 17, 2002 at 02:07:35AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2002 at 02:07:35AM +0800, Rudmer van Dijk wrote:
 > since 2.5.x (can't remember version correctly) the setup for RAM disk changed and I could not build it anymore into the kernel due to compilation errors.
 > In the latest prepatch (2.5.5-pre1) this is still not fixed. I am using the following patch to fix this and it works from 2.5.x upto 2.5.5-pre1 without any problems.

The real fix I think is to fix include/linux/blk.h
setup.c uses it inside CONFIG_BLK_DEV_RAM, but blk.h
only defines it with CONFIG_BLK_DEV_INITRD
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
