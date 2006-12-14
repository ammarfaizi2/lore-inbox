Return-Path: <linux-kernel-owner+w=401wt.eu-S932196AbWLNJwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWLNJwg (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 04:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWLNJwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 04:52:36 -0500
Received: from codepoet.org ([166.70.99.138]:33397 "EHLO codepoet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932196AbWLNJwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 04:52:36 -0500
Date: Thu, 14 Dec 2006 02:52:35 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: Karsten Weiss <K.Weiss@science-computing.de>,
       Christoph Anton Mitterer <calestyo@scientia.net>,
       linux-kernel@vger.kernel.org, Chris Wedgwood <cw@f00f.org>
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory hole mapping related bug?!
Message-ID: <20061214095235.GA10208@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Muli Ben-Yehuda <muli@il.ibm.com>,
	Karsten Weiss <K.Weiss@science-computing.de>,
	Christoph Anton Mitterer <calestyo@scientia.net>,
	linux-kernel@vger.kernel.org, Chris Wedgwood <cw@f00f.org>
References: <Pine.LNX.4.64.0612021202000.2981@addx.localnet> <Pine.LNX.4.61.0612111001240.23470@palpatine.science-computing.de> <20061213202925.GA3909@codepoet.org> <20061214092311.GC6674@rhun.haifa.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061214092311.GC6674@rhun.haifa.ibm.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Dec 14, 2006 at 11:23:11AM +0200, Muli Ben-Yehuda wrote:
> > I just realized that booting with "iommu=soft" makes my pcHDTV
> > HD5500 DVB cards not work.  Time to go back to disabling the
> > memhole and losing 1 GB.  :-(
> 
> That points to a bug in the driver (likely) or swiotlb (unlikely), as
> the IOMMU in use should be transparent to the driver. Which driver is
> it?

presumably one of cx88xx, cx88_blackbird, cx8800, cx88_dvb,
cx8802, cx88_alsa, lgdt330x, tuner, cx2341x, btcx_risc,
video_buf, video_buf_dvb, tveeprom, or dvb_pll.  It seems
to take an amazing number of drivers to make these devices
actually work...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
