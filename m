Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVHBQ4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVHBQ4S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 12:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbVHBQ4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 12:56:18 -0400
Received: from firewall.kernelslacker.org ([68.162.252.20]:64398 "EHLO
	nwo.kernelslacker.org") by vger.kernel.org with ESMTP
	id S261592AbVHBQ4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 12:56:17 -0400
Date: Tue, 2 Aug 2005 12:56:12 -0400
From: Dave Jones <davej@redhat.com>
To: "Michael D. Setzer II" <mikes@kuentos.guam.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel options for cd project with processor family
Message-ID: <20050802165612.GB18410@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Michael D. Setzer II" <mikes@kuentos.guam.net>,
	linux-kernel@vger.kernel.org
References: <42EFDC63.31465.58ED66@mikes.kuentos.guam.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EFDC63.31465.58ED66@mikes.kuentos.guam.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2005 at 08:49:39PM +1000, Michael D. Setzer II wrote:
 > I'm working on the ghost for linux project, which uses various 
 > kernels. The older version 0.14 version had two kernels that support 
 > some configurations. I've added a number of additional builds 
 > adding extra features, but left earlier version in case the later 
 > additions didn't work with hardware. The bzImage6 is the latest and 
 > it works with most hardware, but I found it didn't work on a K6, since 
 > it was build with the Pentium Pro Family. I was able to build one with 
 > the K6 family, and it worked. I had used one of the original kernels 
 > with a K6 before, but this one had a network card that wasn't 
 > supported by it. 
 > 
 > I've built a test set of kernels with the same configuration as the 
 > bzImage6, but changed the Processor family. Below is a list of the 
 > build. I'm interested in which ones would make a difference. I would 
 > think that the 386 version would probable work on all hardware, but 
 > at what cost in performance for creating and restoring the disk 
 > images. G4L uses basically dd, gzip, lzop, bzop, ncftpget, and 
 > ncftpput. With all these images, the g4l iso image is 50MB. 

Your workload is going to be almost entirely IO bound, with
the only CPU intensive parts being 99% in userspace. So any
performance gains by tuning the kernel for a specific CPU are
likely to be unnoticable.  I'd go with a single image supporting
the lowest hardware you intend to support.

CPU tuned variants of gzip/bzip may be more noticable however.

		Dave

