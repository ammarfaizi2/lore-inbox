Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272953AbTG3QDA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 12:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272960AbTG3QC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 12:02:59 -0400
Received: from dsl2.external.hp.com ([192.25.206.7]:24585 "EHLO
	dsl2.external.hp.com") by vger.kernel.org with ESMTP
	id S272953AbTG3QCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 12:02:52 -0400
Date: Wed, 30 Jul 2003 10:02:50 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Grant Grundler <grundler@parisc-linux.org>, ak@suse.de,
       alan@lxorguk.ukuu.org.uk, James.Bottomley@SteelEye.com, axboe@suse.de,
       suparna@in.ibm.com, linux-kernel@vger.kernel.org,
       alex_williamson@hp.com, bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
Message-ID: <20030730160250.GA16960@dsl2.external.hp.com>
References: <20030708213427.39de0195.ak@suse.de> <20030708.150433.104048841.davem@redhat.com> <20030708222545.GC6787@dsl2.external.hp.com> <20030708.152314.115928676.davem@redhat.com> <20030723114006.GA28688@dsl2.external.hp.com> <20030728131513.5d4b1bd3.ak@suse.de> <20030730044256.GA1974@dsl2.external.hp.com> <20030729215118.13a5ac18.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030729215118.13a5ac18.davem@redhat.com>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 09:51:18PM -0700, David S. Miller wrote:
> Make an ext2 filesystem with 16K blocks :-)

Executive summary:
	looks the same as previous 4k block/16k page w/VMERGE enabled.

davem, I thought you were joking...I've submitted a oneliner to
Ted Tyso to increase EXT2_MAX_BLOCK_LOG_SIZE to 64k.
kudos to willy for quickly digging this up.
16k block size Works For Me (tm).

appended is the re-aim-7 results for 16k page/block on ext2.

grant


iota:/mnt# PATH=$PATH:/mnt/usr/local/bin
iota:/mnt# reaim -f /mnt/usr/local/share/reaim/workfile.new_dbase -s100 -e 500 -i 100
REAIM Workload
Times are in seconds - Child times from tms.cstime and tms.cutime

Num     Parent   Child   Child  Jobs per   Jobs/min/  Std_dev  Std_dev  JTI
Forked  Time     SysTime UTime   Minute     Child      Time     Percent
100     108.62   12.46   203.84  5689.35    56.89      4.59     4.46     95
200     217.51   25.29   408.11  5682.60    28.41      9.06     4.36     95
300     325.57   38.05   612.20  5694.63    18.98      12.01    3.85     96
400     434.89   50.67   817.90  5684.16    14.21      15.60    3.75     96
500     545.89   65.74   1024.75 5660.51    11.32      29.45    5.72     94
Max Jobs per Minute 5694.63
iota:/mnt#
