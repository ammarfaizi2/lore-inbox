Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287751AbSBCVHH>; Sun, 3 Feb 2002 16:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287764AbSBCVG5>; Sun, 3 Feb 2002 16:06:57 -0500
Received: from pat.uio.no ([129.240.130.16]:9859 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S287751AbSBCVGt>;
	Sun, 3 Feb 2002 16:06:49 -0500
To: "Burjan Gabor" <buga+dated+1013026971.2270df@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17 NFS hangup
In-Reply-To: <20020203202251.GA22797@csoma.elte.hu>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 03 Feb 2002 22:06:44 +0100
In-Reply-To: <20020203202251.GA22797@csoma.elte.hu>
Message-ID: <shsbsf61di3.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Burjan Gabor <buga+dated+1013026971.2270df@elte.hu> writes:

     > 20:41:40.927855 heron.elte.hu.nfs > partvis.elte.hu.3648238371:
     > reply ok 28 lookup ERROR: No such file or directory (DF)
     > 20:41:40.928622 partvis.elte.hu.3648238372 > heron.elte.hu.nfs:
     > 148 create [|nfs] (DF) 20:41:40.929271 heron.elte.hu.nfs >
     > partvis.elte.hu.3648238372: reply ok 128 create [|nfs] (DF)
     > 20:41:40.930655 partvis.elte.hu.3648238373 > heron.elte.hu.nfs:
     > 100 getattr [|nfs] (DF) 20:41:40.930976 heron.elte.hu.nfs >
     > partvis.elte.hu.3648238373: reply ok 96 getattr REG 100644 ids
     > 0

Nothing abnormal there or in your file. However, when you start
getting 'server not responding' messages, and no tcpdump output it's
usually a sign that the networking layer has given up on you. Any
strange output from 'netstat -s'?

It would be useful to know what networking card/driver combination you
are using? Any firewalls/netfilter setups? Any special mount options?

Cheers,
  Trond
